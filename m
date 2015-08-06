Message-ID: <55C3AEBE.9080603@xenomai.org>
Date: Thu, 06 Aug 2015 15:00:14 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <55C17C8E.5000909@gatech.edu>
In-Reply-To: <55C17C8E.5000909@gatech.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>, "xenomai@xenomai.org" <xenomai@xenomai.org>


> 
> Has anyone successfully used the calibration feature?
> 

Seems to be working on my end (the calibration file is always generated).

# analogy_config analogy0 analogy_ni_pcimio
# analogy_calibrate --device=analogy0 --output=file
# insn_read -d analogy0 -c 0 -R 0 -y /root/file
Calibrated values:
9.116142
9.115817
9.115817
9.116142
9.115817
9.115817
9.116142
9.115817
9.115817
9.115817

~ # cat /proc/analogy/devices
--  Analogy devices --

| idx | status | driver
|  00 | Linked | pci-6221
|  01 | Unused | No driver
|  02 | Unused | No driver
|  03 | Unused | No driver
|  04 | Unused | No driver
|  05 | Unused | No driver
|  06 | Unused | No driver
|  07 | Unused | No driver
|  08 | Unused | No driver
|  09 | Unused | No driver
~ # cat /proc/analogy/drivers
--  Analogy drivers --

| idx | board name
|  00 | analogy_ni_pcimio
|  01 | analogy_8255
~ #

# uname -a
Linux nestor 3.14.44+ #4 PREEMPT Thu Aug 6 19:09:08 CEST 2015 i686 GNU/Linux

# cat /proc/xenomai/version
3.0-rc6

# cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
[...]


-- 
jro

