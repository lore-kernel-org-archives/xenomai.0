Message-ID: <4A09645D.4090003@domain.hid>
Date: Tue, 12 May 2009 13:58:21 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <OF251AD21B.277C167E-ONC12575B4.003ABC22-C12575B4.003B2CCA@datacon.at>
In-Reply-To: <OF251AD21B.277C167E-ONC12575B4.003ABC22-C12575B4.003B2CCA@datacon.at>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] gatekeeper/0
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: henning.richter@domain.hid
Cc: Xenomai help <xenomai@xenomai.org>

henning.richter@domain.hid wrote:
>> And then tries to access the same room on the stack believing that the
>> frame pointer or pc is stored there. Game over.
>>
>> Modify profile_pc function declaration to add the "notrace" qualifier.
>>
>> This bug is a red herring, this is a simple effect of enabling the
> tracing.
> 
> --
>                                                  Gilles.
> 
> Can you give me a hint how to do that or is there sth. to read about?
> 
> Henning

Try:

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 6d34d95..abfd422 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -134,7 +134,7 @@ struct pt_regs {
 struct cpuinfo_x86;
 struct task_struct;

-extern unsigned long profile_pc(struct pt_regs *regs);
+extern unsigned long notrace profile_pc(struct pt_regs *regs);

 extern unsigned long
 convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);

If that is not enough, add notrace where profile_pc is implemented too.

-- 
                                                 Gilles.

