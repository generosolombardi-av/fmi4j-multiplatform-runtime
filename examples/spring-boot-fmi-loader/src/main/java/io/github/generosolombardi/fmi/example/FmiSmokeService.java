package io.github.generosolombardi.fmi.example;

import no.ntnu.ihb.fmi4j.importer.fmi2.CoSimulationFmu;
import no.ntnu.ihb.fmi4j.importer.fmi2.CoSimulationSlave;
import no.ntnu.ihb.fmi4j.importer.fmi2.Fmu;
import org.springframework.beans.factory.DisposableBean;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Service;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.util.LinkedHashMap;
import java.util.Map;

@Service
public class FmiSmokeService implements DisposableBean {

    private static final String FMU_CLASSPATH = "fmu/sample.fmu";

    private Fmu fmu;
    private CoSimulationFmu coSimulationFmu;
    private CoSimulationSlave slave;
    private double time;

    public synchronized Map<String, Object> status() {
        Map<String, Object> status = new LinkedHashMap<>();
        status.put("loaded", fmu != null);
        status.put("initialized", slave != null);
        status.put("time", time);
        status.put("fmu", FMU_CLASSPATH);
        status.put("os.name", System.getProperty("os.name"));
        status.put("os.arch", System.getProperty("os.arch"));
        status.put("sun.arch.data.model", System.getProperty("sun.arch.data.model"));
        return status;
    }

    public synchronized void initialize() {
        if (slave != null) {
            return;
        }
        try {
            ClassPathResource resource = new ClassPathResource(FMU_CLASSPATH);
            if (!resource.exists()) {
                throw new IllegalStateException("Missing classpath FMU: " + FMU_CLASSPATH);
            }

            File tempFmu = Files.createTempFile("fmi4j-smoke-", ".fmu").toFile();
            try (var input = resource.getInputStream()) {
                Files.copy(input, tempFmu.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }
            tempFmu.deleteOnExit();

            fmu = Fmu.from(tempFmu);
            coSimulationFmu = fmu.asCoSimulationFmu();
            slave = coSimulationFmu.newInstance();
            slave.simpleSetup();
            time = 0.0;
        } catch (Exception e) {
            throw new RuntimeException("Unable to initialize FMU smoke test", e);
        }
    }

    public synchronized void step(double stepSize) {
        if (slave == null) {
            initialize();
        }
        if (!slave.doStep(time, stepSize)) {
            throw new IllegalStateException("FMU doStep returned false at time " + time);
        }
        time += stepSize;
    }

    @Override
    public synchronized void destroy() throws Exception {
        if (slave != null) {
            slave.terminate();
            slave.close();
            slave = null;
        }
        if (fmu != null) {
            fmu.close();
            fmu = null;
        }
    }
}

