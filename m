Message-ID: <53C83BFE.9080404@xenomai.org>
Date: Thu, 17 Jul 2014 23:11:26 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAPD=XXg6e79f5-ew6pO9Wp4NN3EamKcmv7pxAPT234q2XS7Ljw@mail.gmail.com>
 <53C82ABD.6060901@xenomai.org>
 <CAPD=XXh-pek-pKJS3xb0EWBXvFW3gwK5ze0aXeYEkLcZCqJwiA@mail.gmail.com>
In-Reply-To: <CAPD=XXh-pek-pKJS3xb0EWBXvFW3gwK5ze0aXeYEkLcZCqJwiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Strange switches to secondary mode with POSIX skin
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Matteo Sommariva <msommariva@gmail.com>
Cc: xenomai <xenomai@xenomai.org>

On 07/17/2014 10:45 PM, Matteo Sommariva wrote:
> 1 for the main thread and 1 for the created thread. Is still something
> wrong?

No, pthread_create uses plain Linux services, so switches to secondary
mode, and the created thread also changes mode when starting.

-- 
                                                                Gilles.

