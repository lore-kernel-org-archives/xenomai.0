References: <CAKJ14NckF3bxk=o5k6U7krGyYLKA0bVRNmsNiT4qki==UAR6Pg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <98365833-e1f8-aec2-dc6f-abf1c259cb67@siemens.com>
Date: Mon, 30 Jan 2017 17:09:55 +0100
MIME-Version: 1.0
In-Reply-To: <CAKJ14NckF3bxk=o5k6U7krGyYLKA0bVRNmsNiT4qki==UAR6Pg@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] POSIX socket() call switches to secondary mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Andreas Glatz <andi.glatz@gmail.com>, xenomai@xenomai.org

On 2017-01-30 13:27, Andreas Glatz wrote:
> Hi
> 
> During optimisation I found out that I have a POSIX socket() call for
> opening a TCP connection that tends to switch to secondary mode, which
> I expected to stay in primary mode. However, then I found a post [1],
> which says that it is in fact considered normal behaviour:
> 
> "rt_dev_socket may cause a switch to secondary mode, yes, this is
> perfectly normal, only sending and receiving data is guaranteed to not
> cause a switch to secondary mode."
> 
> I also saw that this post was from 2014.... I am wondering now if this
> is still considered normal behaviour for the current version of
> socket() (POSIX skin of Xenomai 2.4.6 on arm linux 3.0.35)?

Yes, socket(), just like open(), is an initialization call, and those
may (and usually do) involve non-rt code paths in core and drivers.

In Xenomai 2, we still have the mechanisms in place to allow also
instantiation from RT contexts without mode switches (open_rt/socket_rt
handlers), but there were never any reasonable use cases for that. So
this has been removed from Xemomai 3. In order to stay forward
compatible, you should not rely on the old fragments over there (if your
drivers implement them at all -> no _rt handler, no RT instantiation).

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux

