Subject: Re: [PATCH] cobalt/rtdm: allow for device teardown
References: <20190617155323.21337-1-rpm@xenomai.org>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <3853279e-922b-6c5a-d05f-9508124dbe3f@xenomai.org>
Date: Thu, 20 Jun 2019 09:46:49 +0200
MIME-Version: 1.0
In-Reply-To: <20190617155323.21337-1-rpm@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Philippe Gerum <rpm@xenomai.org>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 6/17/19 5:53 PM, Philippe Gerum wrote:
> rtdm_dev_unregister() will hang soft until all references on the
> dismantled device have been dropped, which in turn cannot happen until
> all rtdm_fds on the device have been closed, which cannot happen until
> all references on those fds have been dropped eventually. We need a
> way to force a teardown on devices, so that rtdm_dev_unregister() will
> not hang.

This needs v2, let's drop this one.

-- 
Philippe.

