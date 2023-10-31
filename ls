[33mcommit caa7c03eb1db8398729dc4f000fe03a07d25e392[m[33m ([m[1;36mHEAD -> [m[1;32mmaster[m[33m, [m[1;31morigin/master[m[33m)[m
Author: Mehdi <mehdi.hatami@mail.polimi.it>
Date:   Thu Oct 12 14:25:57 2023 +0200

    adding data loader example

[1mdiff --git a/Educational-Materials/dataloader.py b/Educational-Materials/dataloader.py[m
[1mnew file mode 100644[m
[1mindex 0000000..e821fa0[m
[1m--- /dev/null[m
[1m+++ b/Educational-Materials/dataloader.py[m
[36m@@ -0,0 +1,60 @@[m
[32m+[m[32mimport os[m
[32m+[m[32mfrom PIL import Image[m
[32m+[m[32mfrom torch.utils.data import Dataset[m
[32m+[m
[32m+[m
[32m+[m[32mclass FloodDataset(Dataset):[m
[32m+[m[32m    def __init__(self, rootdir='dataset', split='train', tranform=None):[m
[32m+[m[32m        super(FloodDataset, self).__init__()[m[41m [m
[32m+[m
[32m+[m[32m        self.rootdir = rootdir[m
[32m+[m[32m        self.split = split[m
[32m+[m[32m        self.transform = tranform[m
[32m+[m
[32m+[m[32m        self.images_base = os.path.join(self.rootdir, self.split)[m[41m [m
[32m+[m[32m        self.items_list, self.classes = self.get_images_list()[m
[32m+[m[41m    [m
[32m+[m[32m    def get_images_list(self):[m
[32m+[m[41m        [m
[32m+[m[32m        items_list = list()[m
[32m+[m[32m        classes = list()[m
[32m+[m[32m        # counter = 0[m
[32m+[m[32m        for idx, (root, dirs, files) in enumerate(os.walk(self.images_base, topdown=False)):[m
[32m+[m[32m            if idx == 0:[m
[32m+[m[32m                classes = dirs[m
[32m+[m
[32m+[m[32m            for file in files:[m
[32m+[m[32m                if file.endswith(".jpg"):[m
[32m+[m[32m                    items_list.append({[m
[32m+[m[32m                        "image": os.path.join(root, file),[m
[32m+[m[32m                        "label": idx - 1,[m
[32m+[m[32m                        "class_name": classes[idx - 1][m
[32m+[m[32m                    })[m
[32m+[m[32m            # counter += 1[m
[32m+[m[32m        return items_list, classes[m
[32m+[m[41m    [m
[32m+[m[32m    def __getitem__(self, index):[m
[32m+[m[32m        image_path = self.items_list[index]['image'][m
[32m+[m[32m        label = self.items_list[index]['label'][m
[32m+[m[32m        class_name = self.items_list[index]['class_name'][m
[32m+[m[41m        [m
[32m+[m[32m        image = Image.open(image_path).convert('RGB')[m
[32m+[m
[32m+[m[32m        if self.transform:[m
[32m+[m[32m            image = self.transform(image)[m
[32m+[m
[32m+[m[32m        return image, label, class_name[m
[32m+[m
[32m+[m[32m    def __len__(self):[m
[32m+[m[32m        return len(self.items_list)[m
[32m+[m[41m  [m
[32m+[m
[32m+[m[32mif __name__ == '__main__':[m
[32m+[m
[32m+[m[32m    dataset = FloodDataset(split='val')[m
[32m+[m
[32m+[m[32m    dataiter = iter(dataset)[m
[32m+[m[32m    image, label, class_name = next(dataiter)[m
[32m+[m[32m    print(image.size)[m
[32m+[m[32m    print(label)[m
[32m+[m[32m    print(class_name)[m
\ No newline at end of file[m
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49293543388.jpg b/Educational-Materials/dataset/test/bridge/49293543388.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..0662e92[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49293543388.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49298495861.jpg b/Educational-Materials/dataset/test/bridge/49298495861.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..0a76dff[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49298495861.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49298506521.jpg b/Educational-Materials/dataset/test/bridge/49298506521.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..7857e5f[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49298506521.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49318937446.jpg b/Educational-Materials/dataset/test/bridge/49318937446.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..fa64905[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49318937446.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49330814718.jpg b/Educational-Materials/dataset/test/bridge/49330814718.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..9270643[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49330814718.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49344820601.jpg b/Educational-Materials/dataset/test/bridge/49344820601.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..bfb48dd[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49344820601.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49348806468.jpg b/Educational-Materials/dataset/test/bridge/49348806468.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..2e4c571[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49348806468.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49353394893.jpg b/Educational-Materials/dataset/test/bridge/49353394893.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..92303dc[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49353394893.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49364342916.jpg b/Educational-Materials/dataset/test/bridge/49364342916.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..e4244bd[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49364342916.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49367086368.jpg b/Educational-Materials/dataset/test/bridge/49367086368.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..ccc756d[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49367086368.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49369295543.jpg b/Educational-Materials/dataset/test/bridge/49369295543.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..5d2186e[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49369295543.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49371226606.jpg b/Educational-Materials/dataset/test/bridge/49371226606.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..2e40b53[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49371226606.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49375055841.jpg b/Educational-Materials/dataset/test/bridge/49375055841.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..fa605a1[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49375055841.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49375276322.jpg b/Educational-Materials/dataset/test/bridge/49375276322.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..772910c[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49375276322.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49375296577.jpg b/Educational-Materials/dataset/test/bridge/49375296577.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..350b39e[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49375296577.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/49379533087.jpg b/Educational-Materials/dataset/test/bridge/49379533087.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..432ea85[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/49379533087.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/50797428558.jpg b/Educational-Materials/dataset/test/bridge/50797428558.jpg[m
[1mnew file mode 100644[m
[1mindex 0000000..d539646[m
Binary files /dev/null and b/Educational-Materials/dataset/test/bridge/50797428558.jpg differ
[1mdiff --git a/Educational-Materials/dataset/test/bridge/50837689073