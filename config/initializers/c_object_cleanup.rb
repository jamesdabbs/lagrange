# C solutions dynamically generate .so files that are versioned to bust the FFI
# library cache. The versions have no other meaning, and should be reset on 
# server restart.
Dir["#{User.solution_path}/c/objects/*"].each { |o| File.delete o }