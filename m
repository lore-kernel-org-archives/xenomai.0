Message-ID: <5061E1C8.5040208@xenomai.org>
Date: Tue, 25 Sep 2012 18:54:32 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMgy_J1-6CqxZV+iqQeC8HUa_rkh2LBoSxRxuiiUi44siKud6g@mail.gmail.com>
In-Reply-To: <CAMgy_J1-6CqxZV+iqQeC8HUa_rkh2LBoSxRxuiiUi44siKud6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Can we patch Xenomai to RHEL 6 kernel source
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Shamju Joseph <shamju.joseph@gmail.com>
Cc: xenomai@xenomai.org

On 09/24/2012 07:45 PM, Shamju Joseph wrote:
> Hi,
> i've a doubt on Xenomai patch.
> Is Xenomai patch applied to only kernel from www.kernel.org?
> Can we patch Xenomai source to RHEL 6 kernel source?

The I-pipe patches delivered with Xenomai sources are made for vanilla
kernels, yes. But if you manage to apply them to another tree, meaning
fix the conflicts, applying the changes to get xenomai running (I mean
running prepare-kernel.sh) should work.

-- 
					    Gilles.

