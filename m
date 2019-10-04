Subject: Re: Xenomai running on IMX8M mini
References: <CAPgPmP3ixSnwSoWuWtS8CtoVVmL+ExALaWuDt3zaorRKy8d4zA@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <0af7ec79-b51e-c222-80ec-f142431b37e0@siemens.com>
Date: Fri, 4 Oct 2019 19:06:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAPgPmP3ixSnwSoWuWtS8CtoVVmL+ExALaWuDt3zaorRKy8d4zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Nitin Kulkarni <nitin.kulkarni@mindmusiclabs.com>, xenomai@xenomai.org

On 04.10.19 18:48, Nitin Kulkarni via Xenomai wrote:
> Hi,
> 
> A few months back I wrote to the mailing list about our attempt to run
> Xenomai on IMX8M mini.
> We had a bumpy ride but we managed to fix the kernel to run Xenomai.
> So we thought it would be helpful to others too and share it with the
> mailing list.
> We identified the irqchip which was causing the issue and fixed it with the
> help of I-pipe porting guidelines. The issue was with the gpc-psci driver
> which was not i-pipe aware. I have created a repository with the patches
> and kernel which we have got working. I don't know how robust it is but we
> haven't seen any issues so far.
> Since this is a vendor specific patch and the concerned driver is not yet
> in the mainline. I am sending the patch here but there is a repository too.
> Here is the link to the repo. I hope it will be helpful.
> https://github.com/kknitin/imx8M-linux-ipipe
> The main patch that solved the lockup issue.
> 

Thanks for sharing!

I had a discussion with NXP the other week, trying to pull them in for more 
upstream work (they are doing Xenomai in their downstream BSPs), for which they 
signaled interest. A good case to follow up on this again, because it shows how 
inefficient the current situation is. If you happen to have a direct channel to 
them as well, please poke them too.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux

