Message-ID: <51003087.4090302@xenomai.org>
Date: Wed, 23 Jan 2013 19:48:39 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANzShzdBHfYGQEzpvnHGhbuwb1KNcdFT-7M8LOV=VoyGa+MZ9Q@mail.gmail.com>
In-Reply-To: <CANzShzdBHfYGQEzpvnHGhbuwb1KNcdFT-7M8LOV=VoyGa+MZ9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Native_skin_Alarm_reprogramming
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Moustapha Bikienga <mbikienga@gmail.com>
Cc: xenomai@xenomai.org

On 01/23/2013 05:40 PM, Moustapha Bikienga wrote:

> Hi.
> 
> Writing a periodic alarm tested program, I noticed that after 10 shot, the
> alarm wasn't reprogramming (or some thing else!).

> Is there any reason for this ?

If you pause() the main thread before returning 0, it will survive many
more shots ;-)
-- 
                                                                Gilles.

