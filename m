Message-ID: <4DE67EED.3050602@domain.hid>
Date: Wed, 01 Jun 2011 20:03:25 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <BANLkTiny4VqoXLOZffQLzNLn3Niqbk2Gzg@domain.hid>
In-Reply-To: <BANLkTiny4VqoXLOZffQLzNLn3Niqbk2Gzg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] test if primary mode
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Jeff Weber <jwamsc@domain.hid>
Cc: xenomai@xenomai.org

On 06/01/2011 06:23 PM, Jeff Weber wrote:
> What is the best call for a user space thread to learn if it is running in
> primary or secondary mode?  (I am using POSIX skin.)

If what you want to know is whether a thread switched to secondary mode
and you did not want it, you may, with pthread_set_mode_np, ask to
receive a signal when this happen.

Any other usage is frowned upon.

-- 
                                                                Gilles.

