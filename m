From: "Frey, Fred (ext ???)" <f.frey@qvii.com>
Subject: Assigning Interrupt Handlers
Date: Fri, 4 Sep 2020 20:49:23 +0000
Message-ID: <MN2PR12MB37578739EBA7AF56D003253FF22D0@MN2PR12MB3757.namprd12.prod.outlook.com>
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

Hello all,

I'd like some guidance on the topic of setting up interrupt handlers to wor=
k with Xenomai.

Platform: Debian Buster on AM335x Arm (Beaglebone Black)
Xenomai version: 3.0.10
`uname -r` : 4.14.108-ti-xenomai-r135

Specifically, I'd like to set up a function to run every time the PRU gener=
ates an interrupt that I've defined.
I'm a little confused on what functionality is actually provided here. Read=
ing the docs I easily can find the 'rtdm_irq_request()' function which look=
s like exactly what I need.
However, when looking through the header files I have, I can't find any men=
tion of this function. Looking through some old mailing list posts, I gathe=
red that this function was
actually only callable from the kernel context. So I guess my question is t=
hree-fold:


  1.  Is it possible for me to register an interrupt handler from userspace=
?
  2.  If not, is the prescribed method of doing this to write a device driv=
er?
  3.  If I have to write a device driver for the PRU, would my  interrupt h=
andler have to live inside of my device driver, or would I be able to regis=
ter

a function inside of my client program to be an interrupt handler?

Thanks  in advance,
Fred
