References: <20170207071938.17419-1-michael.thalmeier@hale.at>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <861e75a8-d92b-e81a-d03b-892250779896@xenomai.org>
Date: Tue, 7 Feb 2017 10:53:56 +0100
MIME-Version: 1.0
In-Reply-To: <20170207071938.17419-1-michael.thalmeier@hale.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] FCSE not working correctly
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Thalmeier <michael.thalmeier@hale.at>, xenomai@xenomai.org

On 02/07/2017 08:19 AM, Michael Thalmeier wrote:
> Hi,
> I am currently working on porting the FCSE patch to kernel 4.9 for our
> custom i.MX28 based board. While investigating a kernel segfault I digged
> deeper into this patchset and also re-tested our currently working 3.12
> kernel (with FCSE).
> What I found, left me wondering if the FCSE patchset was correctly working
> since the beginning. Here follow my findings:

[snip]

> It would be helpful if someone could provide some guidance if this patch
> looks good and how to further verify that everything still works.
> 

The FCSE support has not been actively maintained after the 3.8 kernel
series. Until then, it was used in many applications. This code is now
orphaned from its author and maintainer, Gilles Chanteperdrix, who
passed away last year. I don't know of anyone working on this code today.

AFAIC, I lost track of this code many moons ago and can't help
unfortunately. Since the main target of this code used to be the
armv4/v5 micro-architectures with terrible VIVT caches, there is no real
incentive for me to resume work on it for Xenomai 3 when VIPT is current.

You may want to look the fcse-* branches from this GIT tree, maybe a
glitch happened during a forward port to a more recent kernel since the
latest validated FCSE release: http://git.xenomai.org/ipipe-gch.git/

-- 
Philippe.

