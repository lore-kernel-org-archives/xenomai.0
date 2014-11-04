Date: Tue, 4 Nov 2014 12:59:53 +0100 (CET)
From: Huy Cong Vu <huy-cong.vu@wandercraft.eu>
Message-ID: <297545433.13742.1415102393951.JavaMail.zimbra@wandercraft.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: [Xenomai]  Serial realtime communication
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello everyone, 
I have a Linux thread which read/write to a device connected by usb port & I would like to bring it to Xenomai realtime by using rtdm library. What I wonder is the difference between the functions of rtdm & those of POSIX Xenomai skins, if the goal is only to bring the realtime properties to the process. 
For example, rt_dev_open() (of rtdm) & open() (of POSIX Xenomai). When I use open() of POSIX Xenomai, it works fine, but with rt_dev_open(), it returns -19 as output, with the same port address: 
#define ENODEV 19 /* No such device */ 
And then, I don't really understand the purpose of making a serial communication become "realtime", which means that making the read() procedure more deterministically? 
Best regards, 
Huy Cong 
