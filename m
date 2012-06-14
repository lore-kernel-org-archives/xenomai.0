MIME-Version: 1.0
Date: Thu, 14 Jun 2012 11:40:57 +0200
Message-ID: <CAGq8jPhMdt9TQEL8DZ07JkLOqLyXfJcnOnhK8cyEiApyO+QYkw@mail.gmail.com>
From: Minh GIANG <giang.hminh@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Xenomai] confused in function a4l_sync_dio()
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

hello,

i have just a small question, i don't understand the use of 'mask' value in
function a4l_sync_dio() in other to read/write the value of DIO chanel. I
understands that i have to set configuration with function
a4l_config_subd() to make the DIO chanel in Input or Output. In the xenomai
documentationn, the mask allows to indicates which bit(s) must be modified,
but why we have to indicate it?

Thanks,
