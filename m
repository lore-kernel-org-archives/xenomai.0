References: <BY5PR11MB4306385582356B11B21A19E1BA919@BY5PR11MB4306.namprd11.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Subject: Re: Xenomai Community Call Minutes - March 10, 2021
In-reply-to: <BY5PR11MB4306385582356B11B21A19E1BA919@BY5PR11MB4306.namprd11.prod.outlook.com>
Date: Tue, 23 Mar 2021 09:13:17 +0100
Message-ID: <875z1il23m.fsf@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Wang, Rick Y via Xenomai" <xenomai@xenomai.org>


Hi,

I will not be able to attend the next meeting planned tomorrow. Here is
the update from my side since the last time we met:

- The Xenomai/arm64 port to Dovetail is complete, available from my
  private tree. Tested on kvm/aarch64, imx8mm, rpi4 and Odroid C4 so
  far.

- All pending patches now merged into my 3.2 tree.

- A regression with Xenomai/I-pipe on this tree was fixed a couple of
  days ago, causing switchtest to freeze the machine. You may want to
  rebase on it.

Thanks,

-- 
Philippe.

