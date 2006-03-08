Message-ID: <440F6992.4090304@domain.hid>
Date: Wed, 08 Mar 2006 17:32:34 -0600
From: Jeff Webb <jeff.webb@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Installation feedback on Xenomai from new user
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org


Over the past week or so, I have installed Xenomai (first 2.1-rc3 and then 2.1-rc4) and written a couple of test applications.  Here are some observations from my installation experience:

Installation
------------

I installed Xenomai (2.1-rc3 and 2.1-rc4) on a standard desktop x86 machine (Athlon XP) running fedora core 1 (2.4.32 linux kernel).  Xenomai was easy to configure and install, at least for someone like me who has some experience building and installing custom kernels.  (I have also used RTLinuxFree for several years.)  The installation process was smooth and polished.  The installation instructions were good, although I don't understand the implications of the --enable-x86-sep/tsc user-space configure options, so I just did a plain configure.

When I did 'make xconfig' for the 2.4.32 kernel (patched with xenomai-2.1-rc3 x86), the help buttons for the 'real-time sub-system' menus did not yield any information.  This would have been very helpful.  If these descriptions have not been written, then I understand why the buttons didn't work, but I want to make sure this is not a bug.  The Native-API-Tour.pdf shows a screenshot with descriptions for the xenomai-2.0 configuration program, so I thought maybe these got left out of the 2.4 kernel patch by accident.  I did not try to build a 2.6 kernel to see if it has the same problem.

When I configured the linux kernel, I loaded the kernel config file used in fedora core 1, and then tweaked a few options.  I left modversion support turned on, as I usually do.  This is the process I have used many times when building RTLinuxFree.  Xenomai built and installed without any problems.  I was able to run some user-space programs, but ran into some unresolved symbols when I tried to insert my own kernel modules:

  jittertest2k.o: unresolved symbol rt_pipe_delete
  jittertest2k.o: unresolved symbol rt_timer_read
  jittertest2k.o: unresolved symbol rt_pipe_write
  jittertest2k.o: unresolved symbol rt_pipe_create

Hmmm... no version mangling is happening, even though modversioning should be turned on.  When I look at /proc/ksyms, I see symbols like:

  rt_pipe_delete_R__ver_rt_pipe_delete
  rt_timer_read_R__ver_rt_timer_read

Those version symbols look wrong.  Others look good:

  rt_task_create_Rdba2264e
  rt_registry_bind_R21246ab1

The rt_task_* symbols resolved just fine in my module.  It appears that there is a bug in the modversioning support for the 2.4 kernel, at least.  It only affects some files, though.  If it would help, I can send the output of /proc/ksyms so you can find the affected modules by searching for "__ver_".

After this stumbling block, I disabled modversioning and rebuilt the kernel.  Then things worked just fine.

Documentation
-------------

The documentation I have found is at 
    http://download.gna.org/xenomai/documentation/trunk
      pdf/
        Introduction-to-UVMs.pdf  01-Nov-2005 23:37   515k  
        Life-with-Adeos.pdf       01-Nov-2005 23:37   950k  
        Native-API-Tour.pdf       01-Nov-2005 23:37   1.3M  
        RTDM-and-Applications.pdf 04-Feb-2006 20:31   149k  
        xenomai.pdf               01-Nov-2005 23:37    45k  
      html/api

Am I missing anything? (just making sure)

The Native-API-Tour.pdf was the most helpful to get me started, but needs to be updated for version 2.1, it seems.  This was the closest thing to a tutorial that I found.  The API docs were very useful and well written.  I find them essential.  The others I have not really needed yet, although I have skimmed them over.

General
-------

I am impressed by Xenomai's API.  It seems very straightforward and well thought-out.  I like the registry and was happy find that I can now create pipes without hard-coded device names, unlike RTLinuxFree.  The user-space real-time is great.  That should open up quite a few possibilities, and make my life much easier.

That's all I have for now.  Thanks!

-Jeff

