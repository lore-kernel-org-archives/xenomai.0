Subject: Re: rtdm_fd_is_compat () in xenomai 3.0
References: <CAPNo5QK_QktkN1=g733uRGZwM11FMWgdWi_z1_orvYBM6iY9JA@mail.gmail.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <98448477-32b7-ed90-95cd-4ee614993261@xenomai.org>
Date: Wed, 31 Oct 2018 18:14:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAPNo5QK_QktkN1=g733uRGZwM11FMWgdWi_z1_orvYBM6iY9JA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Manikanta Mylavarapu <mylavarapumanikanta23@gmail.com>, xenomai@xenomai.org

On 10/30/18 6:15 PM, Manikanta Mylavarapu wrote:
> Hi to all,
> 
> I am running 32bit application on 64bit kernel i.e my driver compiled on
> 64bit.
> 
> In my driver I used rtdm_fd_is_compat(), to know user land request came
> from 32-bit or 64bit app.
> 
> My doubt is what it will return if both the driver & app are different?
> 

rtdm_fd_is_compat() returns true when the current request to the 64bit
kernel originates from a 32bit app.

-- 
Philippe.

