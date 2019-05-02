Subject: Re: Request for latest I-pipe arm64 patch
References: <CAPgPmP0GhAroDvwFVR0c6rJP2J1gffHw0=L0p_t9=D9DUoPVVA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <e036f069-1aa3-7edc-274d-0362702a0d3f@xenomai.org>
Date: Thu, 2 May 2019 18:49:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAPgPmP0GhAroDvwFVR0c6rJP2J1gffHw0=L0p_t9=D9DUoPVVA@mail.gmail.com>
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
To: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 5/2/19 12:38 PM, Nitin Kulkarni via Xenomai wrote:
> Hello,
> I am trying to patch a 4.14.78 kernel for arm64 (IMX8m mini), but the
> latest Ipipe patch for arm64
> is at 4.9.51 on the downloads page. Is it possible for someone to generate
> latest patch for 4.14.y for arm64 ? (Preferably 4.14.78).
> I see that the arm64 ipipe kernel is at 4.14.71 but I can't find the script
> to generate patch which was there long time ago.
> 

git diff v4.14.71 is enough with this single-arch tree.

As mentioned in my earlier message to the list, I'm taking over the
I-pipe ARM64 maintenance, in addition to maintaining ARM. I'll push 4.14
patches in the coming days.

-- 
Philippe.

