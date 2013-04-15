References: <oqr4jdyggv.fsf@merlin.sez.to> <51646CBA.40407@xenomai.org>
	<51653957.2070405@grandegger.com> <516AC595.5060103@xenomai.org>
	<516B9C3F.2080107@grandegger.com>
From: Paul Janzen <pcj@xenomai.sez.to>
Date: Mon, 15 Apr 2013 00:18:01 -0700
In-Reply-To: <516B9C3F.2080107@grandegger.com> (Wolfgang Grandegger's message
	of "Mon, 15 Apr 2013 08:20:47 +0200")
Message-ID: <oqr4icp8ie.fsf@merlin.sez.to>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Re: [Xenomai] [PATCH 1/2] rtcan_module: Fix tx_timeout buffer size
	inconsistency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Wolfgang Grandegger <wg@denx.de>, xenomai@xenomai.org

Wolfgang Grandegger <wg@grandegger.com> writes:

>> We have two other unconfirmed CAN patches:
>> http://www.xenomai.org/pipermail/xenomai/2013-March/028111.html
>
> We can add even more PCI IDs here. I'm going to prepare a patch. Just
> support for 4 channel cards needs more effort.

Along these same lines, would there be any interest in a patch
removing the deprecated ESD PCI-CAN driver?

All of the devices claimed by that driver are supported by PLX_PCI.

-- Paul

