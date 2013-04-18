MIME-Version: 1.0
In-Reply-To: <516F9E87.6020002@grandegger.com>
References: <CAD1EtognG+9J_Bbo3x6AsBCJ4eU4SLrXQz=wDvJtFw0vCSZ8NQ@mail.gmail.com>
	<516BA7C4.1050403@grandegger.com>
	<CADVgf9nD4Qkaz54ba1PuKx0h1WkSkhPYQM9C0RU2LkE7aE96nQ@mail.gmail.com>
	<516E336C.1060509@xenomai.org>
	<CADVgf9=CJ0MQEpsub3g=bDZvxk3U3G1tDDvjvFm1jZRmke35fg@mail.gmail.com>
	<CAD1EtoiQm8rZtkDTjZK8Tq3xeDKHULjc7V6Stg=bZ9XpEp5o7w@mail.gmail.com>
	<516F9E87.6020002@grandegger.com>
Date: Thu, 18 Apr 2013 11:08:32 -0400
Message-ID: <CAD1EtoiqYCNq9+LdB=izexUo9+n7MD4YJc_D=0KU0zG82XDkqQ@mail.gmail.com>
From: "Daniel M. Drucker, Ph.D." <dmd@interactive-motion.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Xenomai] patch to src/utils/can/rtcansend.c to support data
 from a file
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: xenomai@xenomai.org

> Well, I do still not see the real benefit of reading just the data from
> a file. Why is a simply shell script not good enough for that purpose?

Speed. Each invocation of rtcansend is slow. If you're sending several
dozen commands (in our case, to set up PDOs and step a servo through
the state machine on startup), it's the difference between:

shell script using rtcansend: 7.6 seconds
using rtcanmultisend: 0.8 seconds

> Anyway, the input file should provide the id, rtr and ext, apart from
> the data, at least.

Ok.

Daniel

