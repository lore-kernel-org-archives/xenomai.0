Message-ID: <DUB121-W85ADA65255AA1EAC6C971814E0@phx.gbl>
From: mobin Motallebizadeh <mobin.seven@live.com>
Date: Wed, 7 May 2014 08:40:37 +0000
In-Reply-To: <53676B5A.4060909@xenomai.org>
References: <DUB121-W16C3D6303DA348F2821C53814C0@phx.gbl>,
 <53676B5A.4060909@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] Round-robin "unknown error -3"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>



> Date: Mon, 5 May 2014 12:43:38 +0200
> From: rpm@xenomai.org
> To: mobin.seven@live.com; xenomai@xenomai.org
> Subject: Re: [Xenomai] Round-robin "unknown error -3"
> =

> On 05/05/2014 12:04 PM, mobin Motallebizadeh wrote:
> > I used the "round-robin-example.c" and got the "round-robin-example-out=
put".the first task returns 0 (success) and works correctlyothers return -3=
.what am I doing wrong.thanks in advance 		 	   		=

> =

> -ESRCH, unknown task. Your demo task exits after 200 ms runtime.
> =

> -- =

> Philippe.
I rewrite the code with another demo(). but still getting "no such process"=
 . I want these three tasks work in round-robin mode. there's no tutorial a=
bout this. Thanks again 		 	   		  =

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: round-robin-example.c.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140507/5ce0847=
b/attachment.txt>
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: round-robin-example-output.txt
URL: <http://www.xenomai.org/pipermail/xenomai/attachments/20140507/5ce0847=
b/attachment-0001.txt>
