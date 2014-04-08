Message-ID: <53444371.7080904@xenomai.org>
Date: Tue, 08 Apr 2014 20:44:01 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <6781B7C7F03D8A4BAF673DC4478144C4069135D7@XSERVER21B.campus.tue.nl>
In-Reply-To: <6781B7C7F03D8A4BAF673DC4478144C4069135D7@XSERVER21B.campus.tue.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] real-time support for CAN-USB devices
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Mnatsakanyan, M." <m.mnatsakanyan@tue.nl>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/08/2014 08:01 PM, Mnatsakanyan, M. wrote:
> Hi,
>
> I am repeating this post because I found out that I did not keep one of the rules
> of mailing list etiquette. Sorry for that. Hopefully this was a reason that my
> question is not being answered.
>
> So here is my question:
> In a Dutch research organization we develop a prototype of a real-time driver
> assistance system based on Xenomai. In non-RT version of this system we widely
> use CAN-USB devices and would like to continue using them also in RT version,
> but we realized that CAN-USB devices are not supported by Xenomai.
> To estimate the future development perspectives for our real-time prototype,
> we would like to know whether you envision the CAN-USB device support in near
> future.

Well, you received no answer because of the question you asked: if 
nobody is working on such a solution, but nobody knows if somebody else 
is working, nobody will answer your question. So, I guess the absence of 
answer is the good sign that nobody is working on such of solution, or 
that people not working on such a solution are not willing to communicate.

Now, we do not have an in-tree RT USB stack, you would need that as a 
start. Such a stack exists, USB4RT, but the page:
http://developer.berlios.de/projects/usb4rt/

does not look very active (only one release, and never updated).

The usb20rt project looks more promising:
http://developer.berlios.de/projects/usb20rt/

-- 
					    Gilles.

