From: Robert Faron <RobertF@Cmslaser.com>
Subject: RTDM driver module
Date: Wed, 28 Oct 2020 15:05:10 +0000
Message-ID: <BN8PR15MB2915240F1729D1165109E036DB170@BN8PR15MB2915.namprd15.prod.outlook.com>
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

I am trying to create a RTDM module. We developed an PCIe FPGA card.  This =
card has many functions that will eventually be used in a real time applica=
tion.  I have already created a cdev device that uses file_opperations main=
ly ioctl.  I am looking for a good example to model the creation of my RTDM=
 driver.  The device is controlled solely through mmio.  Can someone point =
me in the right direction?  Any assistance would be greatly appreciated.

Robert
NOTICE: This e-mail message and all attachments transmitted with it may con=
tain trade secrets and confidential information intended solely for the use=
 of the addressee. If the reader of this message is not the intended recipi=
ent, you are hereby notified that any reading, dissemination, distribution,=
 copying, or other use of this message or its attachments is strictly prohi=
bited. If you have received this message in error, please notify the sender=
 immediately by telephone at 407-679-9716, and delete this message and all =
copies and backups thereof. Thank you
