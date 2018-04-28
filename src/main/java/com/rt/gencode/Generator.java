package com.rt.gencode;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;

import freemarker.template.Configuration;
import freemarker.template.DefaultObjectWrapper;
import freemarker.template.Template;
import freemarker.template.Version;

public class Generator {

    Version version = new Version("2.3.23");
    Configuration cfg = new Configuration(version);
    private String basePath;
    private Model model;
    private String sub = "default";

    public Generator(Model model) {
        // URL resources = Generator.class.getResource("../template");
        cfg.setClassForTemplateLoading(this.getClass(), "/com/rt/template");
        cfg.setObjectWrapper(new DefaultObjectWrapper(version));
        cfg.setDefaultEncoding("UTF-8");
        this.model = model;
    }

    public Generator(String sub, Model model) {
        // URL resources = Generator.class.getResource("../template");
        cfg.setClassForTemplateLoading(this.getClass(), "/com/rt/template/" + sub);
        cfg.setObjectWrapper(new DefaultObjectWrapper(version));
        cfg.setDefaultEncoding("UTF-8");
        this.model = model;
        this.sub = sub;
    }

    public void generateWhat(String what) throws Exception {
        String filePath = getFilePath(what);
        System.out.println("generate file:" + filePath);
        File file = new File(filePath);
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
        if (!file.exists()) {
            file.createNewFile();
        }
        Writer out = new OutputStreamWriter(new FileOutputStream(file), "UTF-8");
        Template dto = cfg.getTemplate(what.toLowerCase() + ".ftl");
        dto.process(model, out);
        out.flush();
        out.close();
    }

    public String getFileName(String what) {
        if (what.startsWith("html") || what.startsWith("jsp")) {
            String[] split = what.split("_");
            if ("mvc".equals(sub)) {
                return split[1] + "." + split[0];
            } else if ("spring".equals(sub) || "layui".equals(sub)) {
                return model.getModuleName() + "_" + split[1] + "." + split[0];
            } else {
                return null;
            }
        } else if (what.equals(GenWhat.FORM)) {
            return model.getModuleName().substring(0, 1).toUpperCase() + model.getModuleName().substring(1)
                    + "SearchForm" + JAVA_SUF;
        } else if (what.equals(GenWhat.DAO_MAPPING)) {
            return model.getModuleName().substring(0, 1).toUpperCase() + model.getModuleName().substring(1) + "DAO"
                    + XML_SUF;
        } else if (what.equals(GenWhat.SERVICE_IMPL)) {
            return model.getModuleName().substring(0, 1).toUpperCase() + model.getModuleName().substring(1)
                    + "ServiceImpl" + JAVA_SUF;
        } else {
            return model.getModuleName().substring(0, 1).toUpperCase() + model.getModuleName().substring(1) + what
                    + JAVA_SUF;
        }
    }

    private String getJavaPath() {
        return getBasePath() + "/src/main/java/" + model.getBasePackage().replace(".", "/") + "/";
    }

    private String getWebPath() {
        if ("mvc".equals(sub)) {
            return getBasePath() + "/src/main/webapp/ftl/" + model.getModuleName() + "/";
        } else if ("spring".equals(sub) || "layui".equals(sub)) {
            return getBasePath() + "/src/main/webapp/center/" + model.getModuleName() + "/";
        }
        return null;
    }

    private String getResourcePath() {
        return getBasePath() + "/src/main/resources/" + model.getBasePackage().replace(".", "/") + "/";
    }

    private String getFilePath(String what) {
        if (what.startsWith("html") || what.startsWith("jsp")) {
            return getWebPath() + "/" + getFileName(what);
        } else if (what.equals(GenWhat.FORM)) {
            if ("mvc".equals(sub)) {
                return getJavaPath() + "action/form/" + getFileName(what);
            } else if ("spring".equals(sub) || "layui".equals(sub)) {
                return getJavaPath() + "search/" + getFileName(what);
            }
        } else if (what.equals(GenWhat.DAO_MAPPING)) {
            return getResourcePath() + "dao/mapping/" + getFileName(what);
        } else if (what.equals(GenWhat.SERVICE_IMPL)) {
            if ("mvc".equals(sub)) {
                return getJavaPath() + "service/impl/" + getFileName(what);
            } else if ("spring".equals(sub) || "layui".equals(sub)) {
                return getJavaPath() + "service/impl/" + getFileName(what);
            }
        } else if (what.equals(GenWhat.ACTION)) {
            if ("mvc".equals(sub)) {
                return getJavaPath() + "service/impl/" + getFileName(what);
            } else if ("spring".equals(sub) || "layui".equals(sub)) {
                return getJavaPath() + "web/" + getFileName(what);
            }
        } else {
            if ("mvc".equals(sub)) {
                return getJavaPath() + what.toLowerCase() + "/" + getFileName(what);
            } else if ("spring".equals(sub) || "layui".equals(sub)) {
                return getJavaPath() + what.toLowerCase() + "/" + getFileName(what);
            }
        }
        return getJavaPath() + what.toLowerCase() + "/" + getFileName(what);
    }

    public void generateAll() throws Exception {
        generateWhat(GenWhat.ACTION);
        generateWhat(GenWhat.DTO);
        generateWhat(GenWhat.DAO);
        generateWhat(GenWhat.DAO_MAPPING);
        generateWhat(GenWhat.FORM);
        generateWhat(GenWhat.SERVICE);
        generateWhat(GenWhat.SERVICE_IMPL);
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public String getBasePath() {
        return basePath;
    }

    public void setBasePath(String basePath) {
        this.basePath = basePath;
    }

    public static final String JAVA_SUF = ".java";
    public static final String XML_SUF = ".xml";

    public class GenWhat {
        public static final String DTO = "DTO";
        public static final String DAO = "DAO";
        public static final String DAO_MAPPING = "DAO_MAPPING";
        public static final String ACTION = "Action";
        public static final String SERVICE = "Service";
        public static final String SERVICE_IMPL = "Service_Impl";
        public static final String FORM = "Form";

        public static final String HTML_MAIN = "html_main";
    }
}
