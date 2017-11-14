.onLoad <-
function(libname, pkgname) {
    ## With Java 9 or later, the JVM needs to be started with
    ##   --add-opens java.base/java.lang=ALL-UNNAMED
    ## to avoid
    ##   WARNING: An illegal reflective access operation has occurred
    ##   WARNING: Illegal reflective access by weka.core.WekaPackageClassLoaderManager (file:/data/rsync/PKGS/RWekajars/inst/java/weka.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int,java.security.ProtectionDomain)
    ##   WARNING: Please consider reporting this to the maintainers of weka.core.WekaPackageClassLoaderManager
    ## when instantiating the Weka package manager.
    ## Ideally we would only pass this when the JVM provides Java >= 9,
    ## but apparently there is no simple way to find this out ahead of
    ## starting it, given that <http://www.rforge.net/rJava/> says that
    ##   On Windows Java is detected at run-time from the registry.
    ## (On Unix, one could go via R CMD config JAVA.)
    ## At least OpenJDK JVMs seem to happily ignore invalid startup
    ## parameters, so for the time being try to always add --add-opens
    ## to the startup parameters, and hope for the best.
    options(java.parameters =
                c(getOption("java.parameters"),
                  "--add-opens=java.base/java.lang=ALL-UNNAMED"))
    .jpackage(pkgname, lib.loc = libname)
}
