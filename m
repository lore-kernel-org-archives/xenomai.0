Message-ID: <54C76713.2010904@xenomai.org>
Date: Tue, 27 Jan 2015 11:23:15 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <54C760BC.7040301@colgp.it>
In-Reply-To: <54C760BC.7040301@colgp.it>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Linux scheduling is hijacked from xenomai scheduling
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Luca Galvagno <luca.galvagno@colgp.it>, xenomai@xenomai.org

On 01/27/2015 10:56 AM, Luca Galvagno wrote:
> Hi to all,
> we are using kernel 2.6.34 with the corresponding ADEOS patch

Which Xenomai release?

> (2.6.34-powerpc-2.10-03.patch ) and Xenomai on a PowerPC MPC5200b.

4 years old kernel and pipeline patch, don't expect much feedback on
this configuration.

> We are facing on a strange behavior when mixing Linux SysCalls with
> Xenomai tasks . The effect of the above mix is that the "pure" (without
> linux syscall) xenomai task continues to run , the remaining "mixed"
> task (for example we have one with a posix socket server) and moreover
> the linux os itself are not scheduled anymore. Specifically, to test
> this behavior, we connected an oscilloscope to a cpu pin , the result is
> that the xenomai task is moving the pin up and down (as it was
> programmed) but the linux machine is neither accessible via ping or via
> SSH.
> 
> Do you have some suggestions, or some tests we can do ?

Xenomai starving the regular kernel from CPU cycles until all the
pending real-time duties have been carried out is the basic idea behind
the dual kernel design, this is nothing strange.

Now the question is: why does your real-time code seem to never complete
its work loop, and there never leaves some CPU time to linux?

-- 
Philippe.

