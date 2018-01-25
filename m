Message-ID: <1516893256.30016.15.camel@sprinte.eu>
From: Julien Blanc <julien.blanc@sprinte.eu>
Date: Thu, 25 Jan 2018 16:14:16 +0100
In-Reply-To: <e707e0e2-a55b-5ac4-f97c-b57882b36eaf@xenomai.org>
References: <1516887803.30016.10.camel@sprinte.eu>
 <e707e0e2-a55b-5ac4-f97c-b57882b36eaf@xenomai.org>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] Posix vs Alchemy - multiplexing and registry
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Le jeudi 25 janvier 2018 à 15:21 +0100, Philippe Gerum a écrit :
> On 01/25/2018 02:43 PM, Julien Blanc wrote:
> > 
> There is no provision for I/O multiplexing with alchemy. Only the
> pipe object embeds a RTDM file descriptor which could be passed to
> libcobalt's select() implementation, other resources (e.g. queues,
> buffers etc) don't.

Thanks for your answer. If i understand correctly, this also means that
it is not recommended to mix both APIs in the same program. For example
a queue created with rt_create_queue cannot be read with
__cobalt_mq_open, am I right ?

> I would suggest to enable the registry for your application (not for
> the entire POSIX API), as you might not need each and every resource
> to be exposed via a fuse-based fs.

This is something i'd rather avoid if possible. Though, thanks for the
pointers, at first glance it seems much simpler than what i feared.

Regards,

Julien

