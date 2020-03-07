APP.seeds = APP.root.join('db', 'seeds')
Dir[File.join(APP.root, *%w[db seeds *.rb])].sort.each { |seed| load(seed) }
