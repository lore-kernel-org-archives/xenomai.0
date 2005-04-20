Message-ID: <42669AFC.8060805@domain.hid>
Date: Wed, 20 Apr 2005 11:10:04 -0700
From: Max Krasnyansky <maxk@domain.hid>
MIME-Version: 1.0
Subject: Re: [Adeos-main] Re: Interrupt Latency Question
References: <1CFEB358338412458B21FAA0D78FE86D4F0D3F@rennsmail02.eu.thmulti.com> <425EA538.5000306@domain.hid> <42654F7E.5090209@domain.hid> <42660D98.9000400@domain.hid>
In-Reply-To: <42660D98.9000400@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: Paolo Mantegazza <mantegazza@domain.hid>
Cc: Fillod Stephane <stephane.fillod@domain.hid>, Wolfgang Grandegger <wolfgang.grandegger@domain.hid>, rtai@domain.hid, adeos-main@gna.org

Paolo Mantegazza wrote:

> For real time CPU reservation I mean something that estabilshes it as 
> such directly at boot and are real time applications that have 
> specifically to use it, the rest is excluded from the very beginning
That's exactly what 'isolcpus' option does. Tasks that want to use isolated
CPU have to explicitly call sched_setaffinity() to migrate.

Max

