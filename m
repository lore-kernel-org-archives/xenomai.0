Message-ID: <51AF1561.6090401@xenomai.org>
Date: Wed, 05 Jun 2013 12:39:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] [POWERPC] bug alert with CONFIG_XENO_HW_UNLOCKED_SWITCH,
 >= kernel 3.4
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <Xenomai@xenomai.org>


A bad bug has been fixed in the unlocked context switching code for 
powerpc platforms. This affects all I-pipe patches for 3.4 kernels and 
above. The typical manifestation of this bug is random segmentation 
faults in user-space applications (sometimes after hours under stress 
load), usually the Xenomai-dependent ones.

A work around not to change the kernel code is to disable 
CONFIG_XENO_HW_UNLOCKED_SWITCH. Patches for fixing this issue are 
available for 3.5.7 and above:

http://git.xenomai.org/?p=ipipe.git;a=commit;h=614aa59453dacf7693fbb18229c27676c2803dbb
http://git.xenomai.org/?p=ipipe.git;a=commit;h=04ea520ab96a16ec65529a2efed92c9a4a8bda34

You might need this companion patch too: 
http://git.xenomai.org/?p=ipipe.git;a=commit;h=047a21b3b203a1fbfce21284f01e376a2cf54c19

HTH,

-- 
Philippe.

