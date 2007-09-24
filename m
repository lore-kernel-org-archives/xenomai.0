Message-ID: <46F7859C.8080505@domain.hid>
Date: Mon, 24 Sep 2007 11:38:36 +0200
From: Jan Kiszka <jan.kiszka@domain.hid>
MIME-Version: 1.0
References: <61839.194.114.62.68.1187258167.squirrel@domain.hid>	<2ff1a98a0708160300r79a717ebt7541c1d6e3da6687@domain.hid>	<11886.194.114.62.68.1187258877.squirrel@domain.hid>	<18116.9932.592597.831501@domain.hid>	<56493.194.114.62.68.1187265227.squirrel@domain.hid>	<2ff1a98a0708160639k555fbb48p98a13892e30e5b02@domain.hid>	<21067.194.114.62.68.1187272557.squirrel@domain.hid>	<2ff1a98a0708160701w17dcf324jb9cb31843d69ca60@domain.hid>	<4760.194.114.62.68.1187274071.squirrel@domain.hid>	<2ff1a98a0708160731k5eefd6b2i417b05b6d329e481@domain.hid>	<23820.194.114.62.37.1190188945.squirrel@domain.hid>	<46F0E63F.7010100@domain.hid>
	<10620.194.114.62.68.1190622767.squirrel@domain.hid>
In-Reply-To: <10620.194.114.62.68.1190622767.squirrel@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] latency problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Nadym Salem <Kaiman@domain.hid>
Cc: xenomai@xenomai.org

Nadym Salem schrieb:
> On Wed, September 19, 2007 11:05, Jan Kiszka wrote:
>> Nadym Salem schrieb:
>>> On Thu, August 16, 2007 16:31, Gilles Chanteperdrix wrote:
>>>> On 8/16/07, Nadym Salem <Kaiman@domain.hid> wrote:
>>>>> On Thu, August 16, 2007 16:01, Gilles Chanteperdrix wrote:
>>>>>> Aha, this probably means that your chipset is not supporte, could you
>>>>>> run lspci and send us the output ?
>>>>> it is attached.
>>>> Could you try to apply the attached patch to xenomai sources ? You
>>>> will then have to recompile your xenomai-patched kernel.
>>> Hmm, I have a new (quite old) machine now and installed Xenomai 2.3.3,
>>> having the same problem as before. The SMI workaround doesn't appear in
>>> the kernel log at all. Last time you gave me a "patch" for smi.c after
>>> which the system at least tried to start the smi workaround. Is there
>>> another possibility like that for my other machine ? I attached the
>>> output
>>> of lspci.
>>> tx in advance,
>>> greets, Nadym
>>> PS: Could it be, that this machine doesn't have SMIs at all ?
>> For sure, but there can also be other hardware-related latency killers.
>> So far the SMI workaround only deals with Intel chipsets (because there
>> are known knobs thanks to the chipset manual).
>> I can't join this party for the next days, but I would like to throw in
>> the question if you already tried to analyse the latency spot with the
>> I-pipe tracer (see Xenomai wiki). That may either underline that it is
>> outside the software's scope (arbitrary delays in unrelated kernel
>> functions) or point to a potential (but less likely) software issue.
> 
> In advice of Gilles, I did a longterm test (from friday evening until this
> morning) on two machines. One being a slower, older one, the other being a
> core2duo. Both having the same latency problems. The Logfiles are
> attached.

Maybe due to my work e-mail interface, I'm having troubles opening those 
tars. Do they now contain an I-pipe tracer output or only the testsuite 
output like in the previous posting? In case of the latter please check [1].

Jan

[1] http://www.xenomai.org/index.php/I-pipe:Tracer

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux

