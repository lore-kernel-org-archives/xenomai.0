Message-ID: <4FE41B17.7030604@xenomai.org>
Date: Fri, 22 Jun 2012 09:13:27 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAHyVJyz4B9Z1nCLEg3G9u-r5d5iHdGwiA78w_enRc--MuVrgMQ@mail.gmail.com>
In-Reply-To: <CAHyVJyz4B9Z1nCLEg3G9u-r5d5iHdGwiA78w_enRc--MuVrgMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai RT user application- POSIX interface
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Mohit Jandwani <mohitjandwani@gmail.com>
Cc: xenomai@xenomai.org

On 06/22/2012 03:57 AM, Mohit Jandwani wrote:
> Hello I am trying to develop a real time Ethercat master on xenomai on an
> exynos board.While I am still stuck with installing xenomai(and plan to
> give it all next week), I have run into some problems which I  have not
> been able to find on the website anywhere.
> 
> I am trying to use the posix skin of xenomai(as I need the stdio functions
> and socket functions) simply because of portability and the fact that I
> don't have to install it(I can build it while building the kernel).What I
> want to ask is:
> If I use the sockets in posix skin , does that still guarantee real-time ?
> Why is the socket interface not listed in the Posix API pdf ?
>  If my code is still real-time does that means I can do file handling in
> real time too?(because I can use local protocol family for reading files
> through sockets)

The sockets call in xenomai posix skin are implemented by the RTDM 
skin, you need an RTDM driver to implement them if you want real-time 
sockets. For instance, for real-time UDP or TCP sockets, you have to 
install RTnet, .

> 
> 
> Also I tried using the pthread file in the posix skin folder, I was unable
> to include the functions
> .Everytime I used pthread_mutex_init it gave me a implicit declaration of
> function error
> .I even tried using #include "posix/pthread" but it didn't work although my
> eclipse clearly shows that the header file has been included.
> (PS: I can include almost all other header files including the
> posix/socket.h  without a problem).
> Is this a bug? or am I doing something wrong?
> 

In order to compile applications using xenomai posix skin, see:
http://www.xenomai.org/index.php/Porting_POSIX_applications_to_Xenomai#Compilation_for_the_Xenomai_POSIX_skin

-- 
                                                                Gilles.

