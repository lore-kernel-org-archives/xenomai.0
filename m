Date: Sun, 5 Oct 2014 12:46:56 +0600
From: Alexey Shaposhnikov <canisdirusleidy@yandex.ru>
Message-ID: <20141005124656.11334ce1@warrawoona.sti>
In-Reply-To: <20141004111706.GA7596@sisyphus.hd.free.fr>
References: <20141004125236.655cdb65@warrawoona.sti>
 <20141004111706.GA7596@sisyphus.hd.free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Porting ipipe to vendor specific kernel. Newbie
 question.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Xenomai <xenomai@xenomai.org>

On Sat, 4 Oct 2014 13:17:06 +0200
Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org> wrote:

> > 1) How to port core patch on newer (than 3.4.6) kernel? Just run
> > genpatches.sh give errors "unknown architecture for driver" and
> > incomplete patch.
> You have to modify genpatches.sh to add the architecture of the
> missing files. This may be easier with versions of genpatches.sh for
> newer kernel versions (the last I-pipe version supported is 3.14.17).

Already tried this. But in result the script parse every driver code change
since 3.4.6 and make over four hundreds errors about missing architecture for
files like usb/serial/whiteheat.c

> Note that I believe someone already did the port to allwinner a10, I
> made comments on these patches, new versions never were posted.

I've seen this in mailing list archive. But pre/post patches have not been
preserved so I prefer to start from scratch instead of reverse engineering
these 6MB of code.

-- 
Alexey Shaposhnikov

