This directory stores the encrypted data bag secret file.  This secret file should not be checked into source control. 
Instead, create it or get it from a site-specific storage for secrets files:

The secret file was created with:

    openssl rand -base64 512 | tr -d '\r\n' > encrypted_data_bag_secret

Once you have a secret file, you can edit the encrypted data bag file.  You will need to install some
plugins to be able to edit encrypted data bags:

    sudo apt-get install ruby1.9.1-dev
    sudo gem install knife-solo
    sudo gem install knife-solo_data_bag

Encrypted data bags are edited using this command format:

    knife solo data bag edit passwords general --secret-file secret/encrypted_data_bag_secret

Or created:

    knife solo data bag create passwords newbagname --secret-file secret/encrypted_data_bag_secret

See: http://distinctplace.com/infrastructure/2013/08/04/secure-data-bag-items-with-chef-solo/
