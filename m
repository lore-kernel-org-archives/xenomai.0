From: Niklaus Giger <niklaus.giger@domain.hid>
Date: Sun, 23 Dec 2007 17:47:35 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_nEpbHYqEVQaJeg8"
Message-Id: <200712231747.35449.niklaus.giger@domain.hid>
Subject: [Xenomai-core] Buildbot is back (and reporting errors)
Reply-To: niklaus.giger@domain.hid
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

--Boundary-00=_nEpbHYqEVQaJeg8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi

During the last two weeks I spent several evenings to bring the buildbot ba=
ck=20
into a good shape.

Please take a look at http://ngiger.dyndns.org/buildbot/ to see the some of=
=20
the results.

I upgraded to the 0.7.6 buildbot revision which has a much improved web dis=
play.

It is therefore possible to limit one's view to specific branches (2.3.x/2.=
4.x/
2.5.x at the moment or just a specifiy builder (e.g. i386_f). I hope that t=
his
makes looking for specific errors easier for everybody.

Most builder use a new approach. As before the buildbot checks out the desi=
red
trunk/branch/tag, downloads the config and (if necessary) a board specific =
patch.
Then the attached make_xenomai.rb Ruby creates a script to checkout the des=
ired
git branch, running the prepare-kernel.sh, configure, make etc. A short for=
 is
available as in
http://ngiger.dyndns.org/buildbot/builders/yosemite_f/builds/0/steps/genscr=
ipt/logs/cmd2run
The full script (which each line surrounded by a if ! cmd ; then exit 2; fi=
) is
then run. This approach should ease a developpers work to reproduce the env=
ironment
where the buildbot reported an error.

In the next few days (beside Christmas with my familiy, some skiing and fri=
ends)
I will improve it to handle "old" version like 2.3.x correctly. Also I will=
 I
builds of the most recent tags in the 2.3. and 2.4 line. Or does someone se=
e the
need for lines like 2.2/2.1 or 2.0?

Also planned is to add one ore more boards to running xeno-test, the Yosemi=
te=20
(PPC440EP based) and HCU3 (PPC405GPr based).

If somebody would like to add more boards please drop me an email (may be w=
ith
an attached config and a script to show how the build was done).

Now about the failures I noticed:

a) The simulator fails in two tests with the vxworks skins. In
http://ngiger.dyndns.org/buildbot/builders/sim_f/builds/1/steps/check_sim/l=
ogs/stdio
you will find at the end the lines
> Some problems were reported in:
> vxworks->t010726-1::
> vxworks->t010823-2::
Going back one finds:
> starting VxWorks services.
> Xenoscope: lt-t010823-2: fatal in MvmIrq (time=3D30000718.974563):
> test interrupted by watchdog.
and
> starting VxWorks services.
> Xenoscope: lt-t010726-1: fatal in MvmIrq (time=3D30000718.974820):
> test interrupted by watchdog.

b) The i386 builds fails in
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c: In
> function 'metapage_read_end_io':
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c:295:
> warning: 'return' with a value, in function returning void
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c: In
> function 'metapage_write_end_io':
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_metapage.c:352:
> warning: 'return' with a value, in function returning void CC [M]=20
> fs/jfs/jfs_logmgr.o
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c: In
> function 'lbmStartIO':
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2165:
> error: too many arguments to function 'lbmIODone'
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c: In
> function 'lbmIODone':
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2238:
> warning: 'return' with a value, in function returning void
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2263:
> warning: 'return' with a value, in function returning void
> /home/buildbot/slave/i386_f/linux-2.6-xenomai/fs/jfs/jfs_logmgr.c:2343:
> warning: 'return' with a value, in function returning void make[3]: ***
> [fs/jfs/jfs_logmgr.o] Error 1

c) The buildbot reported the following error for the PPC build in
http://ngiger.dyndns.org/buildbot/builders/ppc_f/builds/1/steps/build/logs/=
stdio
> /var/buildbot/slave/ppc_f/linux-2.6-xenomai/drivers/net/via-rhine.c:44:1:
> error: unterminated #ifndef make[3]: *** [drivers/net/via-rhine.o] Error 1
> make[2]: *** [drivers/net] Error 2
> make[1]: *** [drivers] Error 2

d) For my PPC405 board I got in
http://ngiger.dyndns.org/buildbot/builders/hcu3_f/builds/2/steps/build/logs=
/stdio
the error
> =A0 CC =A0 =A0 =A0arch/ppc/kernel/smp.o
> /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c: In
> function 'start_secondary':
> /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:341:
> error: implicit declaration of function 'get_paca'
> /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:341:
> error: invalid type argument of '->'
> /home/buildbot/slave/hcu3_f/linux-2.6-xenomai/arch/ppc/kernel/smp.c:341:
> warning: cast from pointer to integer of different size make[2]: ***
> [arch/ppc/kernel/smp.o] Error 1
> make[1]: *** [arch/ppc/kernel] Error 2

e) For the TQM (here I am not sure whether I use a good combination of
the Linux tarball, xenomai and rtnet. So please drop me a note to correct
my error. The steps can be found in=20
http://ngiger.dyndns.org/buildbot/builders/tqm_f/builds/1
but are distributed. I used the xenomai trunk,
ftp://ftp.denx.de/pub/linux/linuxppc_2_4_devel-2006-04-06-1735.tar.bz2
=2Dadeos=3Dksrc/arch/powerpc/patches/adeos-ipipe-2.4.25-*.patch=20
http://rtnet.svn.sourceforge.net/svnroot/rtnet/trunk/rtnet
To compile the linux kernel I called
make ARCH=3Dppc uImage modules
with the following environment flags:
=A0 CFLAGS=3D-g
=A0 CROSS_COMPILE=3Dppc_8xx-
In
http://ngiger.dyndns.org/buildbot/builders/tqm_f/builds/1/steps/mk_kernel/l=
ogs/stdio
you find the following errors:
> In file included from
> /home/buildbot/slave/tqm_f/linux/include/linux/unistd.h:9, from
> init/do_mounts.c:5:
> /home/buildbot/slave/tqm_f/linux/include/asm/unistd.h:385: warning:
> conflicting types for built-in function '_exit' init/do_mounts.c:54: erro=
r:
> static declaration of 'root_device_name' follows non-static declaration
> /home/buildbot/slave/tqm_f/linux/include/linux/fs.h:1568: error: previous
> declaration of 'root_device_name' was here init/do_mounts.c: In function
> 'identify_ramdisk_image':
> init/do_mounts.c:507: warning: pointer targets in passing argument 2 of
> 'read' differ in signedness init/do_mounts.c:542: warning: pointer targets
> in passing argument 2 of 'read' differ in signedness init/do_mounts.c: In
> function 'fill_inbuf':
> init/do_mounts.c:1006: warning: pointer targets in passing argument 2 of
> 'read' differ in signedness init/do_mounts.c: In function 'flush_window':
> init/do_mounts.c:1024: warning: pointer targets in passing argument 2 of
> 'write' differ in signedness make: *** [init/do_mounts.o] Error 1

Best regards
=2D-=20
Niklaus Giger
Wieshoschet 6
CH-8753 Mollis
Tel. ++41 55 612 20 54 (privat)
Tel. ++41 55 618 64 68 (Gesch=E4ft)

--Boundary-00=_nEpbHYqEVQaJeg8
Content-Type: application/x-ruby;
  name="make_xenomai.rb"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="make_xenomai.rb"

#!/usr/bin/ruby
# kate: space-indent on; remove-trailing-space on; replace-tabs-save on; scheme ruby;
# make_xenomai.rb [options]
# * build a Linux kernel with Xenomai extensions
#  starting with a clone of a git repository (if necessary)
#  checkout a build branch from a given tag
#  applies xenomai patch
#  appplies board specific patch
#  configures the kernel (<board>_defconfig or config specified)
#  builds the kernel
#  installs the modules
#  builds the xenomai extensions
#  installs xenomai
#
# == Usage
#
# -h  --help:           displays this help text
#
# -a  --arch:           kernel arch passed to xenomai's scripts/prepare-kernel.sh
#
# -b  --builddir:      where to build the xenomai kernel
#
# -B  --Board:          name of the board to configure
#
# -c  --cross:          CROSS_COMPILE prefix
#
# -d  --destDir:        where to install the resulting binaries.
# Beware: uBoot/zImage will always get installed into /tftpboot/buildbot
#
# -e --xEnopatch        Name pattern for a adeos-ipipe patch inside ksr/arch/<arch>/patches
#
# -f --defconfig        config to use, if not given specified <board>_defconfig
#
# -g  --kernel_git
#
# -p  --patch           full path to board specific kernel patch
#
# -n  --dry-run         for testing
#
# -o  --output          redirect output to this file
#
# -q --quick            only compile kernel. You probabyl just want to check whether the new xenomai changes are okay
#
# -r  --cRossPath       path to be use for crossCompiling
#
# -s  --shortscript     emit short script (without error checking)
#
# -t  --tree            directory to used for the git clone
#
# -v  --version:        version to be compiled (must be a valid git id/tag)
#
# -x  --xeno            root of the checkout xenomai tree
#
require 'getoptlong'
require 'ftools'
require 'rdoc/usage'

#..............................................................................
# setup some global variables (mostly empty)
#..............................................................................
$kernel_git   = "git://www.denx.de/git/linux-2.6-denx.git"
$kernel_git      = "/home/src/linux-2.6-denx"
arch            = 'ppc'
cross           = nil
$board          = 'hcu5'
testRoot        = Dir.pwd
$version        = "DENX-v2.6.23.9"
builddir         = nil
destDir         = nil
svnMode         = nil
crossSpec       = nil
crossPath       = nil
defconfig       = nil
$dryRun         = false
$quick          = false
$output         = nil
$shortscript    = nil
instPath        = nil
kernel_bzip     = nil
xeno            = nil
patch           = nil
xenoPatch       = nil
$linuxGitTree   = nil

#..............................................................................
# Handle the options
#..............................................................................
opts = GetoptLong.new(
  ["--help",    "-h", GetoptLong::NO_ARGUMENT],
  ["--arch",    "-a", GetoptLong::REQUIRED_ARGUMENT],
  ["--builddir","-b", GetoptLong::REQUIRED_ARGUMENT],
  ["--Board",   "-B", GetoptLong::REQUIRED_ARGUMENT],
  ["--cross",   "-c", GetoptLong::REQUIRED_ARGUMENT],
  ["--destDir", "-d", GetoptLong::REQUIRED_ARGUMENT],
  ["--xEnopatch", "-e", GetoptLong::REQUIRED_ARGUMENT],
  ["--defconfig", "-f", GetoptLong::REQUIRED_ARGUMENT],
  ["--git",     "-g", GetoptLong::REQUIRED_ARGUMENT],
  ["--dry-run", "-n", GetoptLong::NO_ARGUMENT],
  ["--output",  "-o", GetoptLong::REQUIRED_ARGUMENT],
  ["--patch",   "-p", GetoptLong::REQUIRED_ARGUMENT],
  ["--quick",   "-q", GetoptLong::NO_ARGUMENT],
  ["--cRossPath", "-r", GetoptLong::REQUIRED_ARGUMENT],
  ["--shortscript", "-s", GetoptLong::REQUIRED_ARGUMENT],
  ["--version", "-v", GetoptLong::REQUIRED_ARGUMENT],
  ["--tree",    "-t", GetoptLong::REQUIRED_ARGUMENT],
  ["--xeno",    "-x", GetoptLong::REQUIRED_ARGUMENT]
)

opts.each do |opt, arg|
  case opt
    when '--help'
      RDoc::usage
      exit
    when '--arch'
      arch = arg
    when '--Board'
      $board = arg
    when '--builddir'
      builddir = arg
    when '--cross'
      cross = arg
    when '--destDir'
      destDir = File.expand_path(arg)
    when '--dry-run'
      $dryRun = true
    when '--xEnopatch'
      xenoPatch = arg
    when '--output'
      $outName = arg
      $output = File.open($outName, "w")
    when '--defconfig'
      defconfig = File.expand_path(arg)
    when '--git'
      $kernel_git = arg
    when '--patch'
      patch = File.expand_path(arg)
    when '--cRossPath'
      crossPath = arg
    when '--shortscript'
      $shortscript = File.open(arg, "w")
    when '--quick'
      $quick = arg
    when '--version'
      $version = arg
    when '--tree'
      $linuxGitTree = arg
    when '--xeno'
      xeno = File.expand_path(arg)
  end
end

#-----------------------------------------------------------------------------
#  setup of helper files for accepting default values
#-----------------------------------------------------------------------------
defaultFile = "#{testRoot}/default"
if !File.exists?(defaultFile)
   aFile = File.open(defaultFile, "w")
   (1..20).each{ |x| aFile.puts }
   aFile.close
end

#-----------------------------------------------------------------------------
#  setup derived values needed later
#-----------------------------------------------------------------------------
if defined?(xeno)
    builddir       = "#{testRoot}/build-xeno-#{$board}-#{arch}-#{$version}"  if ! builddir
    $linuxGitTree    = "#{testRoot}/linux-2.6-xenomai"                       if ! $linuxGitTree
else
    builddir       = "#{testRoot}/build-linux-#{$board}-#{arch}-#{$version}" if ! builddir
    $linuxGitTree    = "#{testRoot}/linux-2.6-denx"                          if ! $linuxGitTree
end
builddir = File.expand_path(builddir)

usePath = ''
if (arch == 'ppc' or 'arch' == 'powerpc' or cross) and ! /powerpc/i.match(RUBY_PLATFORM) then
    cross           = 'ppc_4xxFP-' if ! cross
    kernelOpts      = "ARCH=#{arch}  O=#{builddir}"
    crossPath       = '/usr/local/bin:/opt/eldk/4_1/usr/bin:/usr/bin:/bin'        if ! crossPath
    usePath = " PATH=#{crossPath}" if crossPath
    usePath += " CROSS_COMPILE=#{cross}" if cross
end
puts "cross ist #{cross} arch ist #{arch}"
if arch == 'ppc'
  target = "uImage"
  targetDir = "arch/#{arch}/boot/images"
elsif arch == 'powerpc'
  target = "zImage"
  targetDir = "arch/#{arch}/boot"
else target = "bzImage"
end
kernelOpts  = "O=#{builddir}" if ! kernelOpts

#-----------------------------------------------------------------------------
# Some helper procedures
#-----------------------------------------------------------------------------
def chdir(target)
  cmd = "cd #{target}"
  call_system(cmd)
  return if $dryRun
  Dir.chdir(target)
end

def call_system(cmd)
  $shortscript.puts(cmd) if $shortscript
  cmd = "if ! #{cmd} ; then exit 2; fi "
  # cmd = "#{cmd} && \\"
  if $dryRun then
    puts cmd
    $output.puts(cmd) if $output
    return
  end
  puts "# #{Time.now}: Calling \\#{cmd}"
  res = system(cmd)
  if !res then
     puts "Calling #{cmd} failed. Will exit"
     exit 2
  end
end

#-----------------------------------------------------------------------------
# Setting up a clone of git repository (for performance reason from a already
# downloaded repo)
# When running several time, reset the repo to a good known copy of then
# desired kernel branch/tag
#-----------------------------------------------------------------------------
call_system("git clone --quiet #{$kernel_git} #{$linuxGitTree}") if !File.exists?($linuxGitTree)
chdir($linuxGitTree)
# Revert all old changes from the git repository and get a copy of the desired version.
# This may return 1, if the copy already exists, therefore we do afterwards a git status.
# We have to do this even for quick builds, as we might be on a different branch than before
call_system("git clean -d ; git checkout . ; git checkout -b build-#{$board} #{$version} ; git status" )

#-----------------------------------------------------------------------------
# Figuring out what to do
# Step 1: Clone (if ! quick or first time) a Linux kernel git repository
#         then apply needed patches
#         finally call xenomai's prepare-kernel.sh
#-----------------------------------------------------------------------------

call_system("rm -rf #{builddir}")
call_system("mkdir -p #{builddir}")
call_system("patch -p1 < #{patch}") if patch
if xeno
    # Xenomai-Patches einspielen
    ksrcArch = arch
    ksrcArch = 'powerpc' if arch == 'ppc'
    ksrcArch = 'x86' if arch == 'i386'
    shortVers = /\d*\.\d*\.\d*/.match($version)
    if xenoPatch then
        search = "#{xeno}/ksrc/arch/#{ksrcArch}/patches/#{xenoPatch}"
    else
        search = "#{xeno}/ksrc/arch/#{ksrcArch}/patches/*#{shortVers}*#{arch}*.patch"
    end
    adeosPatch = Dir.glob(search)
    if adeosPatch.length != 1 then
        puts "I looked for patches like #{search}"
        puts "Instead of finding one adeos patch I found #{adeosPatch.inspect}"
        exit 3
    end
    cmd =  "#{xeno}/scripts/prepare-kernel.sh --linux=#{$linuxGitTree} --arch=#{arch} "
    cmd += " --adeos=#{adeosPatch[0]}"
    cmd += " <#{defaultFile}"
    call_system(cmd)
end

#-----------------------------------------------------------------------------
# Step 2: Get a default config and call oldconfig
#-----------------------------------------------------------------------------
if !File.exists?("#{builddir}/.config") then
    if defconfig then
        call_system("cp -v #{defconfig} #{builddir}/.config")
    else
        call_system("make #{usePath} #{kernelOpts} #{$board}_defconfig <#{defaultFile}")
    end
end
call_system("make #{usePath} #{kernelOpts} oldconfig <#{defaultFile}")

#-----------------------------------------------------------------------------
# Step 3: Make the kernel and modules
#        if requested, install it somewhere
#-----------------------------------------------------------------------------
call_system("make #{usePath} #{kernelOpts} #{target} modules")
if destDir then
    call_system("sudo /usr/bin/make #{usePath} #{kernelOpts} INSTALL_MOD_PATH=#{destDir} modules_install")
    call_system("sudo cp -v #{builddir}/#{targetDir}/#{target} /tftpboot/buildbot/#{target}")
    call_system("sudo cp -v #{builddir}/#{targetDir}/#{target} /tftpboot/#{$board.sub(/_[fq]/,'')}/#{target}")
end

#-----------------------------------------------------------------------------
# Step 4: Configure and make the xenomai modules
#        if requested, install it somewhere
#-----------------------------------------------------------------------------
if xeno then
    chdir(builddir)
    cmd  = "#{xeno}/configure --build=i686-linux --host=#{arch} "
    cmd += "#{usePath} CC=#{cross}gcc CXX=#{cross}g++ LD=#{cross}ld" if cross
    call_system(cmd)
    call_system("make #{usePath} clean")
    call_system("make #{usePath} ")
    call_system("sudo /usr/bin/make #{usePath}  DESTDIR=#{destDir} install") if destDir
end

#-----------------------------------------------------------------------------
# Step 5: Cleaning up
#-----------------------------------------------------------------------------
[ $output, $shortscript].each { |file|
    if file then
    file.puts("echo Your job finished without problems. Congratulations!")
    file.close
    system("chmod + #{$outName}")
    end
}

--Boundary-00=_nEpbHYqEVQaJeg8--

