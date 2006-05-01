Message-ID: <44565710.1070002@domain.hid>
Date: Mon, 01 May 2006 14:44:32 -0400
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] xeno-test manpage patch
References: <200604251502.12312.rlenglet@domain.hid>	<4452307D.5060108@domain.hid>
	<200604291803.47373.rlenglet@domain.hid>
In-Reply-To: <200604291803.47373.rlenglet@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Romain Lenglet <rlenglet@domain.hid>
Cc: xenomai@xenomai.org

Romain Lenglet wrote:

<doc fixes, skipped>

>> BUGS
>>
>> -N   name is timestamped, giving uniqueness.  This is a
>> caveat, not a bug
>>     
>
> No, it is a feature. I added it into the documentation of -L 
> and -N.
> By the way, I suggest that you use a timestamp in the RFC 3339 
> format (a subset of ISO 8601):
> date "+%Y-%m-%d %H:%M:%S%:z"
> or, assuming date is GNU date:
> date --rfc-3339=seconds
>
>   
I wanted a compact rep.
is there a std format that doesnt have a space ?
its nicer for us xterm double-click cut-pasters.

>> -p   oops.   Im open to suggestions whether this is worth
>> fixing.
>>
>> (workload mgmt)
>>
>>    workload tasks arent always (ever?) restarted once they
>> finish, so a real /dev/hda1 workload may end before your test
>> does, causing non-uniform &
>> unexpected load variations.
>>
>>     
you used the default load in your explanation, which never ends ( 
/dev/zero supplies infinite 0s)
One of these days Ill try to actually fix it.

>> workloads arent always killed if test is interrupted.
>>     
>
> Added into the bugs section.
>
>
>
> Now, it is my turn to make some remarks on xeno-test... ;)
>   
> 2-
> I don't know why there is a sort of option "-n" in the case:
>         n)
>             # accept note (from the outer process)
>             notes=$OPTARG ;;
> Those three lines should be removed: this is dead code.
>   


Ack.  vestigial cruft. 
was meant to pass info into the script as way to show in 1st lines
how test was run. 

