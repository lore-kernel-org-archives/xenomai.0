Message-ID: <4353D250.9050807@domain.hid>
Date: Mon, 17 Oct 2005 10:33:20 -0600
From: Jim Cromie <jim.cromie@domain.hid>
MIME-Version: 1.0
Subject: Re: [Xenomai-core] Cosmetic changes to script xeno-config + man page
References: <200510170157.58507.rlenglet@domain.hid>
In-Reply-To: <200510170157.58507.rlenglet@domain.hid>
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

>By the way, I noticed that the output of function usage() in that 
>script was wrong. Here is a correct version, to replace the one 
>  
>
if you see an error, please provide a proper patch.
I cannot see the error youve 'corrected' below..

In fact, youve added one;  -v doesnt work,  --v does.

>in scripts/xeno-config.in:
>usage ()
>{
>cat <<EOF
>Usage xeno-config OPTIONS
>Options :
>        --help
>        -v,--verbose
>        --version
>        --cc
>        --cross-compile
>  
>
thx
jimc

