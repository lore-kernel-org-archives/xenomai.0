Message-ID: <516C5868.3000706@xenomai.org>
Date: Mon, 15 Apr 2013 21:43:36 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPpP=rPQa-Fa+1j7Lb11dUX8srkinCQQ2yS2gR5y9f9Pqf1jdg@mail.gmail.com>	<516998B7.9090901@xenomai.org>	<CAPpP=rOEjuy8w0x-_zRv_7vHDOmjU6n1Hi=jrE6UNEULL=zYcQ@mail.gmail.com>	<5169C63B.1070406@xenomai.org>	<CAPpP=rMOmOkd2Gwswu685zsPhxJDMj7GnRWA0yU+gRHmz=V2bw@mail.gmail.com>	<5169EC2C.4000101@xenomai.org>
	<CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>
In-Reply-To: <CAPpP=rNCBdcussSRzHN_Vpjj0afWZRGKRqPXxh7ps2-_GP7nBQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [QUESTION] thread creation and hook function
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: alex alex <duch.alexandre@gmail.com>
Cc: Xenomai <xenomai@xenomai.org>

On 04/15/2013 10:47 AM, alex alex wrote:

>> There are simple ways in the application itself, you do not need a
>> kernel module and a switch hook.
> 
> The reason I use a switch hook is to retrieve informations about context
> switches to produce a Gantt chart of the sechuleur. But maybe hook
> functions are
> not suitable for this? Anyway, I'll try to use the tracer with the latest
> version of xenomai to try to understand what is happening.
> 
> Thank you very much for your replies and advice.


The problem is that you will only get partial information. For instance
you will not see context switches which occur between real-time tasks
running in secondary mode.

-- 
                                                                Gilles.

