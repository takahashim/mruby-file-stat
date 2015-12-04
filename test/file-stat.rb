assert 'File::Stat.new' do
  assert_kind_of File::Stat, File::Stat.new('README.md')
  assert_raise(RuntimeError){ File::Stat.new('unknown.file') }
end

assert 'File.stat' do
  assert_kind_of File::Stat, File.stat('README.md')
end

assert 'File.lstat' do
  assert_kind_of File::Stat, File.lstat('README.md')
end

assert 'File::Stat#initialize_copy' do
  orig = File::Stat.new('README.md')
  copy = orig.dup
  assert_equal orig.inspect, copy.inspect
end

assert 'File::Stat#<=>' do
  stat1 = File::Stat.new('README.md')
  stat2 = File::Stat.new('README.md')
  assert_equal 0, stat1.<=>(stat2)
  assert_equal nil, stat1.<=>(1)
  assert_raise(ArgumentError) { stat1 < 1 }
end

assert 'File::Stat#dev' do
  stat = File::Stat.new('README.md')
  assert_kind_of Fixnum, stat.dev
end

assert 'File::Stat#dev_major' do
  stat = File::Stat.new('README.md')
  if stat.dev_major
    assert_equal Fixnum, stat.dev_major.class
  else
    assert_nil stat.dev_major  ## not supported
  end
end

assert 'File::Stat#dev_minor' do
  stat = File::Stat.new('README.md')
  if stat.dev_minor
    assert_equal Fixnum, stat.dev_minor.class
  else
    assert_nil stat.dev_minor  ## not supported
  end
end

assert 'File::Stat#ino' do
  stat = File::Stat.new('README.md')
  assert_kind_of Numeric, stat.ino
end

assert 'File::Stat#mode' do
  stat = File::Stat.new('README.md')
  assert_kind_of Fixnum, stat.mode
end

assert 'File::Stat#nlink' do
  stat = File::Stat.new('README.md')
  assert_kind_of Fixnum, stat.nlink
end

assert 'File::Stat#uid' do
  stat = File::Stat.new('README.md')
  assert_kind_of Numeric, stat.uid
end

assert 'File::Stat#gid' do
  stat = File::Stat.new('README.md')
  assert_kind_of Numeric, stat.gid
end

assert 'File::Stat#rdev' do
  stat = File::Stat.new('README.md')
  assert_kind_of Fixnum, stat.rdev
end

assert 'File::Stat#rdev_major' do
  stat = File::Stat.new('README.md')
  if stat.rdev_major
    assert_equal Fixnum, stat.rdev_major.class
  else
    assert_nil stat.rdev_major  ## not supported
  end
end

assert 'File::Stat#rdev_minor' do
  stat = File::Stat.new('README.md')
  if stat.rdev_minor
    assert_equal Fixnum, stat.rdev_minor.class
  else
    assert_nil stat.rdev_minor  ## not supported
  end
end

assert 'File::Stat#blocks' do
  stat = File::Stat.new('README.md')
  if stat.blocks
    assert_kind_of Fixnum, stat.blocks
  else
    assert_nil stat.blocks  ## Windows
  end
end

assert 'File::Stat#atime' do
  stat = File::Stat.new('README.md')
  assert_kind_of Time, stat.atime
end

assert 'File::Stat#mtime' do
  stat = File::Stat.new('README.md')
  assert_kind_of Time, stat.mtime
end

assert 'File::Stat#ctime' do
  stat = File::Stat.new('README.md')
  assert_kind_of Time, stat.ctime
end

assert 'File::Stat#birthtime' do
  stat = File::Stat.new('README.md')
  begin
    assert_kind_of Time, stat.birthtime
  rescue NameError
    skip 'This system not support `struct stat.birthtimespec`'
  end
end

assert 'File::Stat#size' do
  stat = File::Stat.new('README.md')
  assert_true 0 < stat.size
end

assert 'File::Stat#blksize' do
  stat = File::Stat.new('README.md')
  if stat.blksize
    assert_true 0 < stat.blksize
  else
    assert_nil stat.blksize  ## Windows
  end
end

assert 'File::Stat#inspect' do
  stat = File::Stat.new('README.md')
  %w(dev ino mode nlink uid gid size blksize blocks atime mtime ctime).all? do |name|
    assert_include stat.inspect, name
  end
end

assert 'File::Stat#ftype' do
  stat = File::Stat.new('README.md')
  assert_equal "file", stat.ftype

  stat = File::Stat.new('bin')
  assert_equal "directory", stat.ftype
end

assert 'File::Stat#directory?' do
  stat = File::Stat.new('README.md')
  assert_false stat.directory?

  stat = File::Stat.new('bin')
  assert_true stat.directory?
end

assert 'File::Stat#readable?' do
  stat = File::Stat.new('README.md')
  assert_true stat.readable?
end

assert 'File::Stat#readable_real?' do
  stat = File::Stat.new('README.md')
  assert_true stat.readable_real?
end

assert 'File::Stat#world_readable?' do
  stat = File::Stat.new('README.md')
  assert_include [Fixnum, NilClass], stat.world_readable?.class
end

assert 'File::Stat#writable?' do
  stat = File::Stat.new('README.md')
  assert_true stat.writable?
end

assert 'File::Stat#writable_real?' do
  stat = File::Stat.new('README.md')
  assert_true stat.writable_real?
end

assert 'File::Stat#world_writable?' do
  stat = File::Stat.new('README.md')
  assert_include [Fixnum, NilClass], stat.world_writable?.class
end

assert 'File::Stat#executable?' do
  stat = File::Stat.new('README.md')
  assert_false stat.executable?

  mrbtest_path = "build/host/bin/mrbtest"
  stat = File::Stat.new(mrbtest_path) rescue File::Stat.new(mrbtest_path+".exe")
  assert_true stat.executable?
end

assert 'File::Stat#writable_real?' do
  stat = File::Stat.new('README.md')
  assert_true stat.writable_real?
end

assert 'File::Stat#file?' do
  stat = File::Stat.new('README.md')
  assert_true stat.file?

  stat = File::Stat.new('bin')
  assert_false stat.file?
end

assert 'File::Stat#zero?' do
  stat = File::Stat.new('README.md')
  assert_false stat.zero?
end

assert 'File::Stat#size?' do
  stat = File::Stat.new('README.md')
  assert_true 0 < stat.size?
end

assert 'File::Stat#owned?' do
  stat = File::Stat.new('README.md')
  assert_true stat.owned?
end

assert 'File::Stat#owned_real?' do
  stat = File::Stat.new('README.md')
  assert_true stat.owned_real?
end

assert 'File::Stat#grpowned?' do
  is_unix = File::Stat.new('/dev/tty') rescue false
  if is_unix
    stat = File::Stat.new('README.md')
    assert_true stat.grpowned?
  else
    skip "is not supported"
  end
end

assert 'File::Stat#pipe?' do
  stat = File::Stat.new('README.md')
  assert_false stat.pipe?
end

assert 'File::Stat#symlink?' do
  stat = File::Stat.new('README.md')
  assert_false stat.symlink?
end

assert 'File::Stat#socket?' do
  stat = File::Stat.new('README.md')
  assert_false stat.socket?
end

assert 'File::Stat#blockdev?' do
  stat = File::Stat.new('README.md')
  assert_false stat.blockdev?
end

assert 'File::Stat#chardev?' do
  stat = File::Stat.new('README.md')
  assert_false stat.chardev?

  begin
    stat = File::Stat.new('/dev/tty')
    assert_true stat.chardev?
  rescue RuntimeError
    skip '/dev/tty is not found'
  end
end

assert 'File::Stat#setuid?' do
  stat = File::Stat.new('README.md')
  assert_false stat.setuid?
end

assert 'File::Stat#setuid?' do
  stat = File::Stat.new('README.md')
  assert_false stat.setgid?
end

assert 'File::Stat#sticky?' do
  stat = File::Stat.new('README.md')
  assert_false stat.sticky?
end
