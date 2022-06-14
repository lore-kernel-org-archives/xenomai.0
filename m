References: <PH1P110MB1050824464C7A004168828B9E2AA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: <evl/heap.h> compile conflict with Boost
Date: Tue, 14 Jun 2022 16:53:02 +0200
In-reply-to: <PH1P110MB1050824464C7A004168828B9E2AA9@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Message-ID: <875yl3qoq2.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Russell Johnson <russell.johnson@kratosdefense.com>
Cc: Philippe Gerum <rpm@xenomai.org>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>


Russell Johnson <russell.johnson@kratosdefense.com> writes:

> [[S/MIME Signed Part:Undecided]]
> From 452e8b2ca8ecd53571a6b1f5d8b9ab23cd67f99d Mon Sep 17 00:00:00 2001
> From: Russell Johnson <russell.johnson@kratosdefense.com>
> Date: Tue, 14 Jun 2022 08:10:14 -0600
> Subject: [PATCH] fixing conflict with C++ [[fallthough]], and maybe at some
>  point in the future with the C2X standard
>

Merged in -next, thanks.

(the original patch got chewed somehow before landing in my mbox, so I
applied it manually - should be ok though).

-- 
Philippe.

