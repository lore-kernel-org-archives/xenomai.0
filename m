Message-ID: <4976EABD.3060505@domain.hid>
Date: Wed, 21 Jan 2009 09:28:29 +0000
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <51CAD0CE1504444DBE77CBBE51A0135D533F9A@slcmail.slc.mew.int>
	<49757B25.8020500@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB0@domain.hid>
	<4975E491.1040506@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D533FB6@domain.hid>
	<4975E612.9040708@domain.hid>
	<51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
In-Reply-To: <51CAD0CE1504444DBE77CBBE51A0135D534028@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] fpu issue
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <sseeger@domain.hid>
Cc: xenomai@xenomai.org

Steven Seeger wrote:
> Hello everyone. I have the dumps here from the header file that Gilles
> was kind enough to provide to me.
> 
> When the problem does not occur:
> 
> sizeof(fpreg_t): 12
> cwd: 0000037f,  swd: 00000000
> fip: 08048c3e,  fcs: 01d00073
> foo: 0959961c,  fos: 0000007b
> FPU registers stack, top at 0:
> 7: Empty
> 6: Empty
> 5: Empty
> 4: Empty
> 3: Empty
> 2: Empty
> 1: Empty
> 0: Empty
> 
> When the problem does occur:
> 
> sizeof(fpreg_t): 12
> cwd: 0000037f,  swd: 00000000
> fip: 08048c3e,  fcs: 01d00073
> foo: 00000000,  fos: 00000000
> FPU registers stack, top at 0:
> 7:  10.000000000
> 6:  25.000000000
> 5: 0
> 4: 0
> 3: 0
> 2: 0
> 1: 0
> 0: - inf.
> 
> What's interesting is that 10.0 and 25.0 are coming from my other task.
> I will attach my code as well. You can see that I'm dumping these values
> in func2, and it seems that the FPU is perhaps left in an undesirable
> state by func?
> 
> This problem occurs on a geode GX1 and a geode LX800. I hate geodes.

Ok. So the FPU state is garbled. Could you put printks in kernel-space
to trace the various FPU operations made by xenomai, you can use strcmp
to check that current->comm is "double_test", and you should put
different printks in all branches of the FPU handling functions, to know
which branches are taken.

-- 
                                                 Gilles.

