Message-ID: <4AF12F3B.9010303@domain.hid>
Date: Tue, 03 Nov 2009 23:37:31 -0800
From: Jonas Buchli <jonas@domain.hid>
MIME-Version: 1.0
References: <B0122F57-107F-4E31-A663-D4DE560C08B8@domain.hid>
	<C790DE41-A093-46C5-9F44-D3F0EA839CF5@domain.hid>
	<20091104065257.A164B3F6C1@domain.hid>
	<4AF12B70.3020004@domain.hid>
	<20091104072605.D26E63F6C1@domain.hid>
In-Reply-To: <20091104072605.D26E63F6C1@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] bring down the system
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Wolfgang Denk <wd@domain.hid>
Cc: Peter Pastor <pastor@domain.hid>, xenomai@xenomai.org

> In message <4AF12B70.3020004@domain.hid> you wrote:
>> did you compile with exactly our compile statement or with additional 
>> flags (i.e. optimization)?
> 
> With optimization, of course.

well, we did not want to burden with you the 70k lines of code, that 
even when compiled optimized leads to the lock ups, and tried to come up 
with this little test case, but to be useful it needs to be compiled 
with the statement provided i guess ;)

could you try if you can reproduce it when not compiled with optimization?

> What sort of machine is this?

it's a 8 cpu dell rack server (sorry i don't have the model at hand and 
am not at the same site as the machine right now).

i attach the content of /proc/cpuinfo what other info would you need?

thanks a lot for looking into this!
jonas


--------------------------------------------------
/proc/cpuinfo (only for one processor, omitted the others, there are 8)


processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 23
model name	: Intel(R) Xeon(R) CPU           E5440  @ 2.83GHz
stepping	: 10
cpu MHz		: 2826.146
cache size	: 6144 KB
physical id	: 0
siblings	: 4
core id		: 0
cpu cores	: 4
apicid		: 0
initial apicid	: 0
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 13
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe nx lm 
constant_tsc arch_perfmon pebs bts pni dtes64 monitor ds_cpl vmx est tm2 
ssse3 cx16 xtpr pdcm dca sse4_1 xsave lahf_lm tpr_shadow vnmi flexpriority
bogomips	: 5652.29
clflush size	: 64
power management:


-- 
--------------------------------------------------------------
Jonas Buchli, Dr.sc., MSc EE
Computational Learning and Motor Control Lab
University of Southern California
http://www-clmc.usc.edu/
+1 (213) 740 67 17
--------------------------------------------------------------

