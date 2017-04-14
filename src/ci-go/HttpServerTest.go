package main
import (
        "flag"
        "io/ioutil"
        "log"
        "net/http"
        "os"
        "strings"
)
var realPath *string
func staticResource(w http.ResponseWriter, r *http.Request) {
        path := r.URL.Path
        request_type := path[strings.LastIndex(path, "."):]
        switch request_type {
        case ".css":
                w.Header().Set("content-type", "text/css")
        case ".js":
                w.Header().Set("content-type", "text/javascript")
        default:
        } 
        fin, err := os.Open(*realPath + path)
        defer fin.Close()
        if err != nil {
                log.Fatal("static resource:", err)
        } 
        fd, _ := ioutil.ReadAll(fin)
        w.Write(fd)
}
func main() {
        realPath = flag.String("path", "", "static resource path")
        flag.Parse()
        http.HandleFunc("/", staticResource)
        err := http.ListenAndServe(":8080", nil)
        if err != nil {
                log.Fatal("ListenAndServe:", err)
        } 
}