From: Russell Johnson <russell.johnson@kratosdefense.com>
Subject: In-band Context Switch on oob_ioctl() call
Date: Fri, 18 Feb 2022 18:24:17 +0000
Message-ID: <PH1P110MB105036E4A7D3954173E4C536E2379@PH1P110MB1050.NAMP110.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello,

I have added the oob_ioctl file descriptor to my driver, and I have made su=
re that I call the necessary evl functions in the open() function in the dr=
iver as well. I have a test app in userspace that is simply opening the dri=
ver and issuing an oob_ioctl every second. What I am seeing in the output f=
rom "evl ps -l" is that the "ISW" and "CTXSW" fields are incrementing with =
every oob_ioctl call. I added in the O_OOB flag to my open call, and I am s=
till seeing the same behavior. I don't get why it would be switching to in-=
band every time the oob_ioctl() is called. Any ideas on what I could be doi=
ng wrong?

Thanks,
Russell
