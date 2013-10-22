Message-ID: <526685BC.10801@xenomai.org>
Date: Tue, 22 Oct 2013 16:03:40 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <7a6b7aaae44e8e8cdd75.1382447102@devws164.be.alcatel-lucent.com>
In-Reply-To: <7a6b7aaae44e8e8cdd75.1382447102@devws164.be.alcatel-lucent.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] Xenomai-forge: psos: extended object names
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Kim De Mey <kim.demey@gmail.com>, xenomai@xenomai.org

On 10/22/2013 03:05 PM, Kim De Mey wrote:
> Extend object names with number to make them unique
>
> Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire@gmail.com>
> Signed-off-by: Ronny Meeus <ronny.meeus@gmail.com>
> Signed-off-by: Kim De Mey <kim.demey@gmail.com>
>
> ---
>
> Although this is not a requirement for pSOS, it would be nice to have
> unique names for debugging purposes. This comes especially in the picture
> with the implementation of registry for pSOS. Without unique names no
> object with duplicate name will be added to registry. Unless changes
> are made to the creation of the files.
>

I'm ok with the intent, not with the implementation. Please check how 
the alchemy API does this via alchemy_build_name().

This will keep the name generation in a single place, and also fix a 
race in the current pSOS emulator code, which post-increments anon_*ids 
in a sloppy non-atomic way.

-- 
Philippe.

