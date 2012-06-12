Message-ID: <4FD78C87.5020000@xenomai.org>
Date: Tue, 12 Jun 2012 20:37:59 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CADULeAbdKdwKp_3kvHkAc9YYKFFUo7mr2qqmLJ5Ok3XeeiTQAQ@mail.gmail.com>
	<CADULeAYv_UfY0PTHX3kA7e7OL7KqKRz=aKGpTUi2SoWwx6qMMg@mail.gmail.com>
In-Reply-To: <CADULeAYv_UfY0PTHX3kA7e7OL7KqKRz=aKGpTUi2SoWwx6qMMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Rtdm driver debugging techniques.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: mohammad khalid shaik <khalid.eee@gmail.com>
Cc: xenomai@xenomai.org

On 06/12/2012 06:59 AM, mohammad khalid shaik wrote:
> I have a question related to debugging techniques used in xenomai.
> 
> I have a pcan-pci rtdm driver which i would like to debug in xenomai
> environment.
> Can any one let me know what are all techniques available for debugging
> rtdm drivers in xenomai?

You can debug with printk

And the I-pipe tracer may come in handy (when you detect a bug trigger a
trace freeze, with some backlog, you are able to know what functions
were called before that).

-- 
                                                                Gilles.

