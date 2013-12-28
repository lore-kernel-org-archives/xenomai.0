Message-ID: <52BEC7B4.8080505@xenomai.org>
Date: Sat, 28 Dec 2013 13:44:36 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <1388233874-6599-1-git-send-email-romain.naour@openwide.fr>
In-Reply-To: <1388233874-6599-1-git-send-email-romain.naour@openwide.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH 0/1] armv5tej support in xenomai
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Romain Naour <romain.naour@openwide.fr>
Cc: xenomai@xenomai.org

On 12/28/2013 01:31 PM, Romain Naour wrote:
> Hi Gilles,
> 
> Can confirm that the armv5tej architecture is supported by xenomai ?
> 
> There are currently some compilation errors like this one on buildroot's autobuilder:
> http://autobuild.buildroot.net/results/e3b/e3b534dafb6dd7d788b0c3629ccc0b25702790f0/build-end.log
> 
> This error is fixed by the following path.

This fixes xenomai build issue, yes, but I have no idea how xenomai
behaves with programs using the jazelle instruction set.

Does gcc generate jazelle instructions now?

-- 
                                                                Gilles.

