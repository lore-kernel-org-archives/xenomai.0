References: <f9fc1bc9-5794-4408-8f85-f7ad3a12a05e@xenomai.org>
 <20180625161807.039269ef@md1pvb1c.ad001.siemens.net>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <f29c9620-e98e-54dd-b421-55b01cef5ee5@xenomai.org>
Date: Mon, 25 Jun 2018 16:55:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180625161807.039269ef@md1pvb1c.ad001.siemens.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3.0.7
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Henning Schild <henning.schild@siemens.com>
Cc: "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 06/25/2018 04:18 PM, Henning Schild wrote:
> Sweet! But what is up with the new git branch "stable/v3.0.x" vs.
> "stable-3.0.x"?

Same. All former Xenomai trees have been merged into a single one on the
gitlab repo as most of them share the same commit history. Branches are
named in order to differentiate between multiple eol/* for 2.x,
stable/current (when 3.1.x is here) and the single devel aka "next" path.

-- 
Philippe.

