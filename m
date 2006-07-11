Message-ID: <e325d110607111035g238d240fo862ce480eb6f3cff@domain.hid>
Date: Tue, 11 Jul 2006 18:35:10 +0100
From: "Kim Chuan Lim" <lim.kim.chuan@domain.hid>
Subject: Re: [Xenomai-help] binding without root access..
In-Reply-To: <44B3DA74.1070405@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <e325d110607110905i40097009n517ad8b05c4b6cb4@domain.hid>
	<44B3DA74.1070405@domain.hid>
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jan Kiszka <jan.kiszka@domain.hid>
Cc: xenomai@xenomai.org

Hi Jan,

I try to run some old example from http://www.captain.at/xenomai.php
I am getting feddup with some examples which keep on hanging my system.
I thought maybe if i run the old examples with normal user mode, i
will not crash the system.

Between, the examples program in testsuits are too much complicated
for beginner like me.
Is there any up to date and easy understandable examples?

Regards,
Kim Chuan



On 7/11/06, Jan Kiszka <jan.kiszka@domain.hid> wrote:
> Kim Chuan Lim wrote:
> > Hi all,
> >
> > Xenomai: binding failed: Operation not permitted.
> >
> > Is it possible for me to do the binding without switching to root?
>
> Switch off XENO_OPT_SECURITY_ACCESS, but you will likely run on other
> barriers later (like the number of mlock'able pages, essential for RT).
> What is your motivation to run RT apps as non-root?
>
> Jan
>
>
>
>

