Message-ID: <53EBC4D9.9040402@xenomai.org>
Date: Wed, 13 Aug 2014 22:04:41 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CANWkrRN=ExZ4qgcXp8+d2NOzBHUvWb2u6Zu8twmr8Vo2VZnnqg@mail.gmail.com>
In-Reply-To: <CANWkrRN=ExZ4qgcXp8+d2NOzBHUvWb2u6Zu8twmr8Vo2VZnnqg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] RTDM !xnpod_unblockable_p() question
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Michael Smith <2michael.smith@gmail.com>, xenomai@xenomai.org

On 08/13/2014 02:28 PM, Michael Smith wrote:
> but there is just not enough information in the code
> or documentation for me to solve it.

Actually, the information can very well be found in the source code.

#define xnpod_unblockable_p() \
    (xnpod_asynch_p() || xnthread_test_state(xnpod_current_thread(), XNROOT))

If you had digged a bit, you would have found that the failing test was
!xnthread_test_state(xnpod_current_thread(), XNROOT)

Which clearly means that you were calling rtdm_mutex_lock() from the 
context of the root thread and that the root thread is unblockable.

Now, if you do not understand what the root thread is, or why it can 
not be suspended from Xenomai's scheduler point of view, clearly, there 
are a thing or two you have not taken the time to understand about 
Xenomai. So, please do not reverse the roles: you are the one who has 
not read enough documentation, please do not accuse us of not having 
written enough.

-- 
                                                                Gilles.

