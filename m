References: <7DEE8379-159F-470A-B22D-01B16FBEECB3@gatech.edu>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Fri, 29 Aug 2014 09:47:24 -0700
In-Reply-To: <7DEE8379-159F-470A-B22D-01B16FBEECB3@gatech.edu> (Yogi A.
 Patel's message of "Thu, 28 Aug 2014 22:13:36 -0400")
Message-ID: <oq1trzkztv.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] Analogy PCI Slot issues?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: xenomai@xenomai.org

"Yogi A. Patel" <yapatel@gatech.edu> writes:

> We run $ sudo analogy_config analogy0 analogy_ni_pcimio 0x1,0a 
>
> and get: $ analogy_config: attach failed err=-2 ERROR: Analogy device loading failed.

What happens if you use "1,10" or "0x1,0x0a"? 

analogy_config uses strtoul to parse options, and "0a" is not a format
that strtoul will recognize.

(It would try to parse it as octal, because it starts with a leading
0, but "a" is not a valid octal digit.)

-- Paul

