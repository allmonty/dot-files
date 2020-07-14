{:user
 {:dependencies        [[cljdev "0.8.0"]]
  :injections          [(require 'nu)]
  :repositories        [["central"  {:url "https://repo1.maven.org/maven2/"
                                     :snapshots false}]
                        ["clojars"  {:url "https://clojars.org/repo/"}]
                        ["nu-maven" {:url "s3p://nu-maven/releases/"
                                     :region "sa-east-1"}]]
  :plugin-repositories [["nu-maven" {:url "s3p://nu-maven/releases/"}]]
  :plugins             [[s3-wagon-private "1.3.3"]
                        [lein-ancient "0.6.15"]]}
 :repl {:plugins      [[cider/cider-nrepl "0.22.4"]
                       [refactor-nrepl "2.5.0-20190723.094516-2"]]
        :dependencies [[nrepl "0.6.0"]
                       [mvxcvi/puget "1.2.0"]]
        :repl-options {:timeout 120000}}}
