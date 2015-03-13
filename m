MIME-Version: 1.0
From: Michael Smith <2michael.smith@gmail.com>
Date: Fri, 13 Mar 2015 10:17:40 +0200
Message-ID: <CANWkrRPz2B5FgOAVLy5-i+DOFOHf5QDZQoHP28n_oAdaSmYTBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] rtdm/driver.h location - Xenomai 3.0
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi.
I am busy porting device drivers over to Xenomai 3.0.
At the moment I'm having trouble figuring out the location of
rtdm/driver.h.
I would assume it should be installed under /usr/include/xenomai, because
in my previous Xenomai 2.x build the rtdm/rtdm_driver.h was located there.
I can see the file in the Xenomai source code but its not installed under
/usr/include/xenomai after Xenomai 3.0 the build and install.
I'm using cobalt with an x86_64 architecture.

Am I missing something? Is there something that I should have setup in the
configuration file with the install? I went back and had a look in the
Linux kernel
build setup under the Xenomai heading, but I could not see any obvious
options that I missed.

Thanks
Michael Smith

