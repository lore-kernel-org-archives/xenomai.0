Message-ID: <49E24045.4060204@domain.hid>
Date: Sun, 12 Apr 2009 21:25:57 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <Pine.LNX.4.64.0904081243120.22300@domain.hid>
	<Pine.LNX.4.64.0904081659110.22300@domain.hid>
	<Pine.LNX.4.64.0904101250540.4820@domain.hid>
	<49E1C43A.6060009@domain.hid>
	<Pine.LNX.4.64.0904121117380.23562@domain.hid>
In-Reply-To: <Pine.LNX.4.64.0904121117380.23562@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] Xeno-test bug
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Martin Shepherd <mcs@domain.hid>
Cc: xenomai@xenomai.org

Martin Shepherd wrote:
> On Sun, 12 Apr 2009, Gilles Chanteperdrix wrote:
>> No, that is the intended behaviour, as the name "cleanup_load" suggests,
>> cleanup_load is intended to be called when generate_load terminates.
> 
> I think that you mean "when the dd process that generate_loads() runs,
> terminates", not when generate_loads() itself ends. Generate_loads is
> supposed to end as soon as it has started the specified number of dd
> processes in a background.
> 
>> The
>> real problem is to know why generate_loads terminates early. Maybe you
>> have not installed dd ?
> 
> No, dd is started, and continues to run fine in the background, even
> after the EXIT handler is triggered. What I found was that the EXIT
> handler was not being triggered by dd terminating, but because the
> generate_loads() procedure which starts it, is executed in a
> sub-shell, which terminates.
> 
> Removing extraneous code, the problematic statements of the script are
> as follows:
> 
>     loudly() {
>         eval $* &
>         wait $!
>     }
> 
>     mkload() { dd if=$device of=/dev/null $* & }
> 
>     generate_loads() {
>         loudly mkload
>     }
> 
>     generate_loads
> 
> When generate_loads() is executed above, it calls loudly(), telling it
> to execute mkload(). For some reason, loudly() does this as follows:
> 
>   eval mkload &
> 
> which, if one expands the definition of mkload(), is equivalent to:
> 
>   (dd if=$device of=/dev/null $* &) &
> 
> In other words, the "eval mkload &" statement starts mkload() within a
> background process, then mkload() also starts the dd in a second
> background process. The background dd process then continues, while the
> process that started it terminates normally, and triggers the EXIT
> handler.
> 
> This happens because loudly() is implemented like:
> 
>      loudly() {
>          eval $* &
>          wait $!
>      }
> 
> instead of the more obvious:
> 
>      loudly() {
>          eval $*
>      }

Ok. Thanks for taking the time to debug this. If you made modifications
(other than replacing #!/bin/sh with #!/bin/bash) which make xeno-test
run in your case, send a patch which we will be happy to merge.

-- 
					    Gilles.

