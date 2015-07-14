Date: Tue, 14 Jul 2015 05:58:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Message-ID: <20150714035825.GD1971@hermes.click-hack.org>
References: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CO1PR01MB256AC4CE16186B5C49AEABD949B0@CO1PR01MB256.prod.exchangelabs.com>
Subject: Re: [Xenomai] xenomai latency test hangs due to kernel paging
	request
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Gowtham Garimella <ggarime1@jhu.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On Tue, Jul 14, 2015 at 12:57:10AM +0000, Gowtham Garimella wrote:
> -------------- next part --------------
> A non-text attachment was scrubbed...
> Name: config_current
> Type: application/octet-stream
> Size: 97142 bytes
> Desc: config_current
> URL: <http://xenomai.org/pipermail/xenomai/attachments/20150714/28c5e2ed/attachment.obj>

I had a look at your configuration, and see almost nothing wrong at
first sight. You can try turning off CONFIG_DEBUG_STACK_USAGE, in
case that option creates the problem.

-- 
					    Gilles.
https://click-hack.org

